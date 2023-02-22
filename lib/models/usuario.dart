// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

// Método de serialización de string de json a lista de Usuario
List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

// Método de serialización de lista de Usuario a cadena de caracteres
String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  // Clase que representa un objeto Usuario con id, nombre, contraseña y una
  // lista de puntuaciones.
  Usuario({
    required this.id,
    required this.username,
    required this.password,
    required this.score,
  });

  int id;
  String username;
  String password;
  List<Score> score;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        score: List<Score>.from(json["score"].map((x) => Score.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "score": List<dynamic>.from(score.map((x) => x.toJson())),
      };
}

class Score {
  Score({
    required this.game,
    required this.record,
  });

  String game;
  int record;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        game: json["game"],
        record: json["record"],
      );

  Map<String, dynamic> toJson() => {
        "game": game,
        "record": record,
      };
}
