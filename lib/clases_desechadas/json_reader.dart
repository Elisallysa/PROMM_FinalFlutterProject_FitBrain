import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

// Lector de archivos json
class JsonReader {
  List<dynamic> getOption = [];
  JsonReader() {
    loadData();
  }

  // Método de prueba para comprobar que lee los datos del archivo users.json
  void printData() {
    rootBundle.loadString('database/users.json').then((value) => print(value));
  }

  void loadData() {
    rootBundle.loadString('database/users.json').then((value) {
      Map datos = json.decode(value);
      print(datos);
    });
  }

  // Método que lee el archivo json
  Future<List> readJson() async {
    final String response = await rootBundle.loadString('database/users.json');
    final data = await json.decode(response);
    return data["items"];
  }

  bool login(String username) {
    Map<String, dynamic> items = jsonDecode('database/users.json');
    return items[0]['username'] == username;
  }

  final jsonReader = JsonReader();
}
