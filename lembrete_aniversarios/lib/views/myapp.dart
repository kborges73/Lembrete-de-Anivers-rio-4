import 'package:agenda_aniversarios/views/atualizar_pessoa.dart';
import 'package:agenda_aniversarios/views/detalhar_aniversario.dart';
import 'package:agenda_aniversarios/views/listar_aniversarios.dart';
import 'package:agenda_aniversarios/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:agenda_aniversarios/views/my_homepage.dart';

import 'cadastrar_pessoa.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Agenda de Aniversários',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.nomeRota,
        routes: {
          SplashScreen.nomeRota: (context) => SplashScreen(),
          MyHomePage.nomeRota: (context) => MyHomePage(),
          CadastrarPessoa.nomeRota: (context) => CadastrarPessoa(),
          DetalharAniversario.nomeRota: (context) => DetalharAniversario(),
          AtualizarPessoa.nomeRota: (context) => AtualizarPessoa(),
          ListarAniversarios.nomeRota: (context) => ListarAniversarios(),
        });
  }
}
