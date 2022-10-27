import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A validator is a function that processes a `FormField`
/// and returns an error [String] or null. A null [String] means that validation has passed.
class Validador {
  static FormFieldValidator validarNome() {
    return (value) {
      String patttern = r'(^[a-zA-Z ]*$)';
      RegExp regExp = RegExp(patttern);
      if (value!.isEmpty) {
        return "Informe o nome";
      } else if (!regExp.hasMatch(value)) {
        return "O nome deve conter caracteres de a-z ou A-Z";
      } else
        return null; // Passou na validação
    };
  }

  static FormFieldValidator validarEmail() {
    return (value) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (value!.isEmpty) {
        return "Informe o Email";
      } else if (!regExp.hasMatch(value)) {
        return "Email inválido";
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator validarData() {
    return (value) {
      if (value!.isEmpty) {
        return "Informe a data";
      } else {
        try {
          DateTime dateTime1 = DateFormat('dd/MM/yyyy').parseStrict(value);
        } catch (e) {
          return ("Data Incorreta ! Verifique os valores e o uso da / como separador");
        }
      }
    };
  }
}
