import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool whatsappNotification = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool alarmSound = false;

  List<bool> selectedDays = [false, false, false, false, false, false, false];
  List<String> weekDays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadNotificationSettings();
  }

  Future<void> _initNotifications() async {
    if (await Permission.notification.request().isGranted) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      final DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }
  }

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // Horário
      final hour = prefs.getInt('alarm_hour') ?? selectedTime.hour;
      final minute = prefs.getInt('alarm_minute') ?? selectedTime.minute;
      selectedTime = TimeOfDay(hour: hour, minute: minute);

      // Dias
      final daysJson = prefs.getString('alarm_days');
      if (daysJson != null) {
        List<dynamic> savedDays = jsonDecode(daysJson);
        selectedDays = savedDays.map((e) => e as bool).toList();
      }

      // WhatsApp e alarme
      whatsappNotification = prefs.getBool('whatsapp') ?? false;
      alarmSound = prefs.getBool('alarm') ?? false;
    });
  }

  Future<void> _saveNotification() async {
    final prefs = await SharedPreferences.getInstance();

    // Salvar horário
    await prefs.setInt('alarm_hour', selectedTime.hour);
    await prefs.setInt('alarm_minute', selectedTime.minute);

    // Salvar dias
    await prefs.setString('alarm_days', jsonEncode(selectedDays));

    // Salvar toggles
    await prefs.setBool('whatsapp', whatsappNotification);
    await prefs.setBool('alarm', alarmSound);

    // Agendar alarmes
    if (alarmSound) {
      List<int> activeDays = [];
      for (int i = 0; i < selectedDays.length; i++) {
        if (selectedDays[i]) {
          // Domingo=7, Segunda=1 ...
          activeDays.add(i == 0 ? 7 : i);
        }
      }
      if (activeDays.isNotEmpty) {
        await scheduleAlarm(selectedTime, activeDays);
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notificação configurada com sucesso!'),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.pop(context);
  }

  Future<void> scheduleAlarm(TimeOfDay time, List<int> daysOfWeek) async {
    final now = DateTime.now();

    for (int weekday in daysOfWeek) {
      DateTime scheduledDate = DateTime(
        now.year,
        now.month,
        now.day + ((weekday - now.weekday + 7) % 7),
        time.hour,
        time.minute,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        weekday, // ID único
        'Alarme',
        'Hora do alarme!',
        scheduledDate.toLocal(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_channel',
            'Alarme',
            channelDescription: 'Canal para alarmes',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            sound: RawResourceAndroidNotificationSound('alarm'), // res/raw/alarm.mp3
          ),
          iOS: DarwinNotificationDetails(
            sound: 'alarm.aiff',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green[700]!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Configurar Notificação'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horário
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () => _selectTime(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Horário: ${selectedTime.format(context)}'),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Dias
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDays[index] = !selectedDays[index];
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedDays[index]
                              ? Colors.green[700]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            weekDays[index],
                            style: TextStyle(
                              color: selectedDays[index]
                                  ? Colors.white
                                  : Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tipos de notificação
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // WhatsApp
                    Row(
                      children: [
                        const Icon(Icons.chat, color: Colors.green),
                        const SizedBox(width: 16),
                        const Text('WhatsApp'),
                        const Spacer(),
                        Switch(
                          value: whatsappNotification,
                          onChanged: (value) {
                            setState(() {
                              whatsappNotification = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Alarme
                    Row(
                      children: [
                        const Icon(Icons.volume_up, color: Colors.orange),
                        const SizedBox(width: 16),
                        const Text('Alarme Sonoro'),
                        const Spacer(),
                        Switch(
                          value: alarmSound,
                          onChanged: (value) {
                            setState(() {
                              alarmSound = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveNotification,
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
