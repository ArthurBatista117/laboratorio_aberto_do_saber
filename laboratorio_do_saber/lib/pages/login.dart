import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key_form = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {
    "email": TextEditingController(),
    "senha": TextEditingController(),
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
      backgroundColor: Colors.green[50],
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
                    //EMAIL
                    TextFormField(
                      controller: controllers["email"],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor digite seu email";
                        } else if (value.length < 2) {
                          return "Digite um email válido";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                    ),
                    Text('\n'),

                    //SENHA
                    TextFormField(
                      controller: controllers["senha"],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor digite sua senha";
                        } else if (value.length < 6) {
                          return "Digite uma senha válida";
                        } 
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Senha",
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
