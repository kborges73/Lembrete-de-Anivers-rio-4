import 'package:agenda_aniversarios/models/categorias.dart';
import 'package:agenda_aniversarios/models/pessoa.dart';
import 'package:agenda_aniversarios/util/database_helper.dart';
import 'package:agenda_aniversarios/util/validador.dart';
import 'package:flutter/material.dart';

import 'my_homepage.dart';

class CadastrarPessoa extends StatefulWidget {
  static const nomeRota = "/cadastrarpessoa";

  const CadastrarPessoa({Key? key}) : super(key: key);

  @override
  _CadastrarPessoaState createState() => _CadastrarPessoaState();
}

class _CadastrarPessoaState extends State<CadastrarPessoa> {
  final _formKey = GlobalKey<FormState>();

  // String? nome, email, aniversario;
  Pessoa? pessoa = Pessoa();

  final controllerNome = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerAniversario = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controllerNome.dispose();
    controllerEmail.dispose();
    controllerAniversario.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pessoa?.categoria = Categorias.amigo.name; //ADICIONAR
    controllerNome.addListener(() {
      pessoa?.nome = controllerNome.text;
    });
    controllerEmail.addListener(() {
      pessoa?.email = controllerEmail.text;
    });
    controllerAniversario.addListener(() {
      pessoa?.aniversario = controllerAniversario.text;
    });
  }

  String categoria = Categorias.amigo.name;

  bool validate = false;

  // referencia nossa classe single para gerenciar o banco de dados
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário com Validação'),
      ),
      body: SingleChildScrollView(
        /*child: Container(
          margin: const EdgeInsets.all(15.0),*/
        child: Form(
          key: _formKey,
          child: _formUI(),
        ),
      ),
      //  ),
    );
  }

  Widget _formUI() {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Amigo"), value: Categorias.amigo.name),
      DropdownMenuItem(child: Text("Familia"), value: Categorias.familia.name),
      DropdownMenuItem(child: Text("Colega"), value: Categorias.colega.name),
      DropdownMenuItem(child: Text("Vizinho"), value: Categorias.vizinho.name),
      DropdownMenuItem(child: Text("Cliente"), value: Categorias.cliente.name),
    ];

    return Column(
      children: <Widget>[
        TextFormField(
          controller: controllerNome,
          decoration: const InputDecoration(hintText: 'Nome Completo'),
          maxLength: 40,
          validator: Validador.validarNome(),
        ),
        TextFormField(
          controller: controllerEmail,
          decoration: const InputDecoration(hintText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          maxLength: 40,
          validator: Validador.validarEmail(),
        ),
        TextFormField(
          controller: controllerAniversario,
          decoration: const InputDecoration(hintText: 'Data de aniversário'),
          keyboardType: TextInputType.datetime,
          maxLength: 10,
          validator: Validador.validarData(),
        ),
        DropdownButtonFormField(
          value: categoria,
          onChanged: (String? newValue) {
            setState(() {
              pessoa?.categoria = newValue!;
            });
          },
          items: menuItems,
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: inserir,
          child: const Text('Enviar'),
        )
      ],
    );
  }

  inserir() {
    if (_formKey.currentState!.validate()) {
      // Sem erros na validação
      _formKey.currentState!.save();
      Map<String, dynamic> row = pessoa!.toMap();
      dbHelper.insert(row);
      _voltarDialog();
    } else {
      // erro de validação
      setState(() {
        validate = true;
      });
    }
  }

  _voltarDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastro de Aniversários'),
          content: const Text('Cadastro Efetuado Com Sucesso !'),
          actions: [
            TextButton(
              child: const Text('Voltar para a tela inicial'),
              onPressed: () {
                Navigator.pushNamed(context, MyHomePage.nomeRota);
              },
            ),
          ],
        );
      },
    );
  }
}
