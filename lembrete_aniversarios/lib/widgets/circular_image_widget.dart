import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  final ImageProvider imageProvider;
  final double width;
  final double heigth;

  CircularImageWidget({
    required this.imageProvider,
    this.width = 500,
    this.heigth = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: heigth,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 5,
            ),
            shape: BoxShape
                .circle, //Define a forma como o conteiner decorado será renderizado
            image: DecorationImage(
              fit: BoxFit
                  .cover, //Define a forma como a imagem irá ocupar o conteiner
              image: imageProvider,
            )));
  } //build
}// class