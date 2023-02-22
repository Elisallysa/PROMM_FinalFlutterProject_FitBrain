import 'package:flutter/material.dart';

class AppTheme {
  // Clase con los colores, estilos de texto, etc. de FitBrain. Se puede acceder
  // a los mismos de forma estática.
  AppTheme._();

  // ROSADOS
  static const Color pinkEmphasis = Color.fromRGBO(227, 79, 114, 1);
  static const Color lightPink = Color.fromRGBO(239, 108, 138, 1);
  static const Color palePink = Color.fromRGBO(254, 222, 255, 1);
  static const Color berryShadow = Color.fromARGB(255, 128, 36, 105);

  // AZULES VERDOSOS
  static const Color lightGreenishBlue = Color.fromARGB(255, 214, 242, 235);
  static const Color greenishBlue = Color.fromRGBO(157, 212, 196, 1);
  static const Color tile = Color.fromRGBO(108, 193, 179, 1);
  static const Color greenEmphasis = Color.fromRGBO(5, 89, 88, 1);
  static const Color darkTile = Color.fromRGBO(8, 171, 168, 1);

  // MOSTAZA
  static const Color mustard = Color.fromRGBO(222, 156, 49, 1);

  // TEXTO
  static const Color greyText = Colors.grey;

  static const TextStyle gameTitle = TextStyle(
      color: greenEmphasis, fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle gameDescription =
      TextStyle(color: Colors.white, fontSize: 18);

  static const TextStyle appBarTitle =
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle categoryTitle =
      TextStyle(color: lightPink, fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle alertaTitle =
      TextStyle(color: darkTile, fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle categorySubtitle = TextStyle(
    color: greenEmphasis,
    fontSize: 13,
    letterSpacing: 0.18,
  );
}
