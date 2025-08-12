import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

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
              child: Text("Aqui ficará o texto do Sobre",
               style: TextStyle(
                backgroundColor: Colors.greenAccent,
                color: Colors.white
               ),
               ),
              )
          ],
        ),
      ),
    );
  }
}