import 'package:agenda_aniversarios/models/pessoa.dart';
import 'package:agenda_aniversarios/util/database_helper.dart';
import 'package:agenda_aniversarios/views/atualizar_pessoa.dart';
import 'package:agenda_aniversarios/views/my_homepage.dart';
import 'package:flutter/material.dart';

class DetalharAniversario extends StatefulWidget {
  static const nomeRota = "/detalharaniversario";

  //String? nome, email, aniversario, categoria;
  final Pessoa? pessoa;

  const DetalharAniversario({Key? key, this.pessoa}) : super(key: key);

  _DetalharAniversarioState createState() => _DetalharAniversarioState();
}

class _DetalharAniversarioState extends State<DetalharAniversario> {
  // referencia nossa classe single para gerenciar o banco de dados
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    final Set dados = ModalRoute.of(context)!.settings.arguments as Set;
    Pessoa pessoa = dados.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(pessoa.nome!),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Email: ${pessoa.email!}",
          textScaleFactor: 1.5,
        ),
        Text(
          "Aniversário : ${pessoa.aniversario!}",
          textScaleFactor: 1.5,
        ),
        Text(
          "Categoria : ${pessoa.categoria!}",
          textScaleFactor: 1.5,
        ),
        ElevatedButton(
          onPressed: () => {
            Navigator.pushReplacementNamed(context, AtualizarPessoa.nomeRota,
                arguments: {pessoa})
          },
          child: new Text('Editar'),
        ),
        ElevatedButton(
          onPressed: () => {_excluirDialog(pessoa.id!)},
          child: new Text('Excluir'),
        ),
      ]),
    );
  } // build

  _excluirDialog(int id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Cadastro de Aniversários'),
          content: Text('Exclusão Efetuada Com Sucesso !'),
          actions: [
            TextButton(
              child: Text('Voltar para a tela inicial'),
              onPressed: () {
                dbHelper.delete(id);
                Navigator.pushNamed(context, MyHomePage.nomeRota);
              },
            ),
          ],
        );
      },
    );
  }
} // class _DetalhesAniversarioState 
