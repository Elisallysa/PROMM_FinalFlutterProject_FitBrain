import 'package:flutter/material.dart';

class Emoticon extends StatelessWidget {
  // Devuelve una cartita con emoticono.
  final String emoticono;

  const Emoticon({Key? key, required this.emoticono}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            emoticono,
            style: const TextStyle(fontSize: 28),
          ),
        ));
  }
}
