import 'dart:core';
import 'package:agenda_aniversarios/models/pessoa.dart';
import 'package:agenda_aniversarios/util/database_helper.dart';
import 'package:agenda_aniversarios/views/detalhar_aniversario.dart';
import 'package:flutter/material.dart';

class ListarAniversarios extends StatefulWidget {
  static const nomeRota = "/listaraniversarios";

  const ListarAniversarios({Key? key}) : super(key: key);

  _ListarAniversarioState createState() => _ListarAniversarioState();
}

class _ListarAniversarioState extends State<ListarAniversarios> {
  Pessoa? pessoa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Aniversários Cadastrados'),
        ),
        body: FutureBuilder<List>(
          initialData: List.empty(), //Cria uma lista vazia
          future: _consultar(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      pessoa = snapshot.data![i];
                      return _buildRow(context, pessoa!);
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }

  Widget _buildRow(BuildContext context, Pessoa pessoa) {
    return ListTile(
      title: Text(pessoa.nome!),
      onTap: () {
        Navigator.pushReplacementNamed(context, DetalharAniversario.nomeRota,
            arguments: {pessoa});
      },
    );
  }

  Future<List<Pessoa>> _consultar() async {
    var db = DatabaseHelper.instance;
    var result = await db.queryAllRows();
    //Retorna uma lista de Mapas, onde cada mapa pode ser convertido em uma Pessoa
    //através to método Pessoa.fromMap
    List<Pessoa>? list = result.isNotEmpty
        ? result.map((c) => Pessoa.fromMap(c)).toList()
        : null;

    return list!;
  }
}
