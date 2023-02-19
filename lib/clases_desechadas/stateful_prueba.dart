import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:fit_brain/utils/login_validator.dart';
import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../utils/json_util.dart';

class PruebaFull extends StatefulWidget {
  const PruebaFull({super.key});

  @override
  State<PruebaFull> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PruebaFull> {
  List<Usuario>? usuarios;
  var isLoaded = false;
  final usernameController = TextEditingController();
  final pwdController = TextEditingController();
  var success = 'LOGIN CORRECTO';
  var denied = 'LOGIN INCORRECTO';
  var mensaje = '';

  @override
  void initState() {
    super.initState();
    getData();
    writeUsuarioToJson();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  getData() async {
    usuarios = await JsonUtil().readLocalJson('database/users.json');
    if (usuarios != null) {
      setState(() {
        isLoaded = true;
        print('entra en setstate');
      });
    }
  }

  writeUsuarioToJson() async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    var path = directory.path;
    File f = File('$path/database/file.txt');
    f.writeAsString('hola caracola');
    print(f.path);
    File fi = File('database/caca.txt');

    print(fi.path);
    if (await fi.exists()) {
      print('EXISTE ARCHIVO FI');
    }
    if (f.existsSync()) {
      print('HOLA ASÍ FUNCIONA Y EXISTE EL FILE');
    }
    final user = Usuario(id: 4, username: 'eli', password: '1a', score: []);
    JsonUtil().writeToJson('database/file.txt', user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("stful"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            TextField(
              obscureText: true,
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'user',
              ),
            ),
            TextField(
              controller: pwdController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (LoginValidation(usuarios!,
                        username: usernameController.text,
                        password: pwdController.text)
                    .isRegistered()) {
                  setState(() {
                    mensaje = success;
                  });
                } else {
                  setState(() {
                    mensaje = denied;
                  });
                }
              },
              child: const Text('click'),
            ),
            Text(mensaje)
          ],
        )));
  }
}
