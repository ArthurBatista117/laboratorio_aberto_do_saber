import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var cpfMask = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.eager
);

var telefoneMask = MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.eager
);

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  Future<void> enviarCadastro(BuildContext context) async {
    final url = Uri.parse(
      "https://laboratorio-aberto-do-saber-6.onrender.com/cadastro",
    );
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nome": controllers["nome"]!.text,
        "cpf": controllers["cpf"]!.text,
        "telefone": controllers["telefone"]!.text,
        "email": controllers["email"]!.text,
        "senha": controllers["senha"]!.text,
      }),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 201) {
      final body = response.body;
      print("Resposta: $body");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    } else {
      final body = response.body;
      print("Resposta: $body");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao cadastrar')));
    }
  }

  final _key_form = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {
    "nome": TextEditingController(),
    "cpf": TextEditingController(),
    "telefone": TextEditingController(),
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
      body: Builder(
        builder: (context) => Form(
          key: _key_form,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //NOME
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
                        controller: controllers["cpf"],
                        inputFormatters: [cpfMask],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor digite seu CPF";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "CPF",
                        ),
                      ),
                      Text("\n"),
                      //email
                      TextFormField(
                        controller: controllers['email'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Esse campo é obrigatório';
                          }
                          return null;
                        },
                      ),
                      Text("\n"),
                      //senha
                      TextFormField(
                        controller: controllers['senha'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'senha',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite uma senha';
                          } else if (value.length < 6) {
                            return 'Sua senha deve ter mais de 6 dígitos';
                          }
                          return null;
                        },
                      ),
                      Text("\n"),
                      //telefone
                      TextFormField(
                        controller: controllers['telefone'],
                        inputFormatters: [telefoneMask],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Telefone',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Seu telefone';
                          } 
                          return null;
                        },
                      ),
                      Text("\n"),
                      ElevatedButton(
                        onPressed: () async {
                          if (_key_form.currentState!.validate()) {
                            await enviarCadastro(context);
                          }
                        },
                        child: Text("Cadastrar"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
