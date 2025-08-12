import 'package:flutter/material.dart';
import 'package:laboratorio_do_saber/pages/cadastro.dart';
import 'package:laboratorio_do_saber/pages/homePage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green[700],
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          centerTitle: true
        ),
      ),
      home: HomePage(),
    );
  }
}
