import 'package:agenda_aniversarios/views/my_homepage.dart';
import 'package:agenda_aniversarios/widgets/circular_image_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async'; //para usar a classe Timer

class SplashScreen extends StatefulWidget {
  static const nomeRota = "/splashscreen";
  __SplashScreenState createState() => __SplashScreenState();
}

class __SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, MyHomePage.nomeRota);
    });
  }

  @override
  Widget build(BuildContext context) {
    // O AssetImage é um provider, que é o responsável por obter uma imagem,
    // tendo como base seu endereço (url).
    //Esse endereço deve ser registrado no pubspec.yaml

    //O codigo abaixo cria uma anaimação
    //Padding reserva espaço na área interna do container onde o widget será exibido
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularImageWidget(
                imageProvider: AssetImage('images/splashscreenimage.png'),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  child: const Text('Aguarde ...',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ))),
              Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue[900]),
                  ))
            ]));
  }
}
