import 'dart:io';

import 'package:fit_brain/clases_desechadas/stateful_prueba.dart';
import 'package:fit_brain/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const FitBrain());
  checkFile();
}

class FitBrain extends StatelessWidget {
  const FitBrain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Brain',
    );
  }
}

Future<void> checkFile() async {
  File fi = File('scores/scores.json');

  print(fi.path);
  if (await fi.exists()) {
    print('EXISTE ARCHIVO FI');
  } else {
    print('NO EXISTE MALDITASEA');
  }
}
