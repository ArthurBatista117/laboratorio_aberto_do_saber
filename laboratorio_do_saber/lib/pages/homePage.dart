import 'package:flutter/material.dart';
import 'package:laboratorio_do_saber/pages/cadastro.dart';
import 'package:laboratorio_do_saber/pages/lerQrcode.dart';
import 'package:laboratorio_do_saber/pages/login.dart';
import 'package:laboratorio_do_saber/pages/notificacao.dart';

import 'package:laboratorio_do_saber/pages/sobre.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("L.A.S", style: TextStyle(fontSize: 50)),
        backgroundColor: Colors.green,
      ),

      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: EdgeInsets.all(40),

      child: Center(

        child: Column(

          children: [
            //Sobre
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sobre()),
                );
              },

              child: Padding(

                padding: EdgeInsets.all(20),
                child: Row(children: [Icon(Icons.message), Text("Sobre...")]),
              ),
            ),
            Text("\n"),
            //Ler QR CODE
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LerQrCode())
                );
              },

              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.qr_code_2_sharp),
                    Text(""),
                    Text("Ler qr code"),
                  ],
                ),
              ),
            ),
            Text("\n"),
            //Notificações
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen())
                );
              },

              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.notifications),
                    Text(""),
                    Text("Notificações"),
                  ],
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(10)),
            //Botões de Cadastro e Login
            Row(

              children: [
                //Login
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login())
                      );
                  },
                  child: Text("Login"),
                ),

                Padding(padding: EdgeInsets.all(10)),
                //Cadastro
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                  },
                  child: Row(children: [Icon(Icons.create), Text("Cadastro")]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
