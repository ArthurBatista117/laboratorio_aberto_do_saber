import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key_form = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {
    "nome": TextEditingController(),
    "CPF": TextEditingController(),
    "Telefone": TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("L.A.S", style: TextStyle(fontSize: 50)),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _key_form,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Login", style: TextStyle(fontSize: 30)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    //nome
                    TextFormField(
                      controller: controllers["nome"],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor digite seu nome";
                        } else if (value.length < 2) {
                          return "Digite um nome válido";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nome",
                      ),
                    ),
                    Text('\n'),
                    //CPF
                    TextFormField(
                      controller: controllers["CPF"],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor digite seu CPF";
                        } else if (value.length != 11) {
                          return "Digite um CPF válido";
                        } else if (int.tryParse(value) == null) {
                          return "Seu CPF deve conter apenas números";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "CPF",
                      ),
                    ),
                    Text("\n"),
                    ElevatedButton(
                      onPressed: () {
                        if (_key_form.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Realizando cadastro...')),
                          );
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
