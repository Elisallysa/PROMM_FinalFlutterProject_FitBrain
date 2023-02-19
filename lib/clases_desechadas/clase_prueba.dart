import 'dart:convert';

import 'package:fit_brain/clases_desechadas/json_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];

  Map<String, dynamic> userMap = jsonDecode('database/users.json');
  var _user;

  @override
  void initState() {
    super.initState();
    _user = User.fromJson(userMap);
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('database/users.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('A random idea:'),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {},
            child: const Text('TextButton'),
          ),
          Text(_items.length.toString()),
          if (_user != null) Text(_user.username)
        ],
      ),
    );
  }
}

void getData() {
  JsonReader().loadData();
}
