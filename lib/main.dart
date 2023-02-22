import 'package:fit_brain/screens/game_cambio.dart';
import 'package:fit_brain/screens/home_screen.dart';
import 'package:fit_brain/screens/login_screen.dart';
import 'package:flutter/material.dart';

// Main App de Fit Brain
void main() {
  runApp(const FitBrain());
}

class FitBrain extends StatelessWidget {
  const FitBrain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Brain',
      home: LoginScreen(),
    );
  }
}
