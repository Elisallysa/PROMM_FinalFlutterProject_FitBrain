import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class JsonUtil {
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

  // Lee el archivo json local
  Future<List<Usuario>?> readLocalJson(String jsonPath) async {
    final String response = await rootBundle.loadString(jsonPath);
    print('READ LOCAL JSON');
    print(jsonPath);
    return usuarioFromJson(response);
  }

  Future<File> writeToJson(String jsonPath, Usuario usuario) {
    final file = File(jsonPath);
    Future<bool> existe = File(jsonPath).exists();
    if (existe == true) {
      print('ASÍ SÍ');
    }
    if (file.existsSync()) {
      print('EXISTE FICHERO');
    } else {
      print('NO EXISTE JODER');
    }
    // Write the file
    return file.writeAsString(usuario.toJson().toString(),
        mode: FileMode.append, flush: false);
  }
}
