import 'package:agenda_aniversarios/models/categorias.dart';
import 'package:agenda_aniversarios/models/pessoa.dart';
import 'package:agenda_aniversarios/util/database_helper.dart';
import 'package:agenda_aniversarios/util/validador.dart';
import 'package:agenda_aniversarios/views/my_homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AtualizarPessoa extends StatefulWidget {
  static const nomeRota = "/atualizarpessoa";

  //final Pessoa? pessoa;

  const AtualizarPessoa({Key? key}) : super(key: key);

  @override
  _AtualizarPessoaState createState() => _AtualizarPessoaState();
}

class _AtualizarPessoaState extends State<AtualizarPessoa> {
  final _formKey = GlobalKey<FormState>();

  // referencia nossa classe single para gerenciar o banco de dados
  final dbHelper = DatabaseHelper.instance;
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    final Set dados = ModalRoute.of(context)!.settings.arguments as Set;
    Pessoa pessoa = dados.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário com Validação'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: _formUI(pessoa),
          ),
        ),
      ),
    );
  }

  Widget _formUI(Pessoa pessoa) {
    //String? categoria = pessoa.categoria;

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
          initialValue: "ID = ${pessoa.id.toString()}",
          enabled: false,
        ),
        TextFormField(
          initialValue: pessoa.nome,
          //decoration: InputDecoration(hintText: "${pessoa.nome}"),
          maxLength: 40,
          validator: Validador.validarNome(),
          onChanged: (String? val) {
            _formKey.currentState?.validate();
            pessoa.nome = val;
          },
        ),
        TextFormField(
            initialValue: pessoa.email,
            keyboardType: TextInputType.emailAddress,
            maxLength: 40,
            validator: Validador.validarEmail(),
            onChanged: (String? val) {
              _formKey.currentState?.validate();
              pessoa.email = val;
            }),
        TextFormField(
            initialValue: pessoa.aniversario,
            keyboardType: TextInputType.datetime,
            maxLength: 10,
            validator: Validador.validarData(),
            onChanged: (String? val) {
              _formKey.currentState?.validate();
              pessoa.aniversario = val;
            }),
        DropdownButtonFormField(
          value: pessoa.categoria,
          onChanged: (String? newValue) {
            pessoa.categoria = newValue!;
          },
          items: menuItems,
        ),
        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () {
            _editar(pessoa);
            _voltarDialog();
          },
          child: new Text('Atualizar'),
        )
      ],
    );
  }

  void _editar(Pessoa pessoa) async {
    if (_formKey.currentState!.validate()) {
      // Sem erros na validação
      _formKey.currentState!.save();
      Map<String, dynamic> row = {
        'id': pessoa.id,
        'nome': pessoa.nome,
        'email': pessoa.email,
        'aniversario': pessoa.aniversario,
        'categoria': pessoa.categoria
      };
      final id = await dbHelper.update(row);
      print('quantidade de registros atualizados : $id');
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
          title: Text('Cadastro de Aniversários'),
          content: Text('Registro Atualizado Com Sucesso !'),
          actions: [
            TextButton(
              child: Text('Voltar para a tela inicial'),
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
