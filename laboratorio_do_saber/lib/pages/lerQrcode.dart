import 'package:flutter/material.dart';

class LerQrCode extends StatelessWidget {
  const LerQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("L.A.S", style: TextStyle(fontSize: 50)),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Em construção 🏗️",
               style: TextStyle(
                fontSize: 40
               ),
               ),
              )
          ],
        ),
      ),
    );
  }
}