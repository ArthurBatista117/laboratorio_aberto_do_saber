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
              child: Text("O Laboratório Aberto do Saber é uma iniciativa inovadora que busca expandir os limites da sala de aula, criando um ambiente digital interativo como extensão do espaço escolar. A plataforma tem como objetivo facilitar o acesso ao conhecimento, promover a aprendizagem autônoma e melhorar a comunicação entre alunos e professores por meio de recursos tecnológicos intuitivos.",
              style: TextStyle(
                fontSize: 16,
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}