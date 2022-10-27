import 'package:flutter/material.dart';
import 'package:agenda_aniversarios/views/cadastrar_pessoa.dart';

import 'listar_aniversarios.dart';

class MyHomePage extends StatefulWidget {
  static const nomeRota = "/myhomepage";

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildMenu(),
      appBar: AppBar(
        title: const Text("Não esqueça !"),
      ),
      body: Center(
        child: Column(),
      ),
    );
  }

  Widget _buildMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
              //Se não colocar isso, a barra azul fica muito grande (altura)
              height: 80.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Opções'),
              )),
          ListTile(
            title: Text('Cadastrar Pessoa'),
            onTap: () {
              Navigator.pushNamed(context, CadastrarPessoa.nomeRota);
            },
          ),
          ListTile(
            title: Text('Listar Aniversarios'),
            onTap: () {
              Navigator.pushNamed(context, ListarAniversarios.nomeRota);
            },
          )
        ],
      ),
    );
  }
}
