import 'dart:io';

import 'package:fit_brain/models/pago_cambio_game.dart';
import 'package:fit_brain/screens/game_cambio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class JsonUtil {
// Clase que incluye algunas funciones para manejar la serialización de objetos
// y la lectura de ficheros json.

  // Obtiene una lista de Usuarios de una base de datos en remoto
  Future<List<Usuario>?> getUsuarios(String uriAdress) async {
    var client = http.Client();
    var uri = Uri.parse(uriAdress);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return usuarioFromJson(json);
    }
    return null;
  }

  // Lee el archivo json local y devuelve lista de usuarios
  Future<List<Usuario>?> readLocalJson(String jsonPath) async {
    final String response = await rootBundle.loadString(jsonPath);
    return usuarioFromJson(response);
  }

  // Lee el archivo json local y devuelve lista de pagos
  Future<List<CambioPago>?> readCambioGameJson(String jsonPath) async {
    final String response = await rootBundle.loadString(jsonPath);
    return cambioPagoFromJson(response);
  }

  Future<File> writeToJson(String jsonPath, Usuario usuario) {
    // No funciona en local
    final file = File(jsonPath);
    //Future<bool> existe = File(jsonPath).exists();
    // Escribe el archivo
    return file.writeAsString(usuario.toJson().toString(),
        mode: FileMode.append, flush: false);
  }
}
