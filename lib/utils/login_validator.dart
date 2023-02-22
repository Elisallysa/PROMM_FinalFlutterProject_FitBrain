import '../models/usuario.dart';

class LoginValidation {
// Valida si un usuario y contraseña están almacenados en una lista de usuarios
  List<Usuario> lista;
  String username;
  String password;

  LoginValidation(this.lista, {required this.username, required this.password});

  bool isRegistered() {
    for (final user in lista) {
      if (user.username == username && user.password == password) return true;
    }
    return false;
  }
}
