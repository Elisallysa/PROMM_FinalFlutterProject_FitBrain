// Modelo de usuario. Mapeará los datos del fichero json a objetos User.
class User {
  int? id;
  String? username;
  String? password;
  Map<String, dynamic> scores = {};

  User(this.id, this.username, this.password, this.scores);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    scores = json['score'];
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'username': username, 'password': password, 'score': scores};
}
