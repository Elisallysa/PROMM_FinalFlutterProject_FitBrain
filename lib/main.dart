import 'package:fit_brain/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FitBrain());
}

class FitBrain extends StatelessWidget {
  const FitBrain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Brain',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LogInScreen(),
    );
  }
}
