import 'package:flutter/material.dart';

import '../../theme/fitbrain_theme.dart';
import '../game_cambio.dart';
import '../home_screen.dart';
import '../login_screen.dart';
import '../signin_screen.dart';
import 'game_list_view.dart';

class FitBrainDrawer extends StatelessWidget {
  // Drawer navegable de Fit Brain. Se usará para facilitar la evaluación: incluye
  // las pantallas que contiene la aplicación.
  const FitBrainDrawer({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // En este drawer solo aparecen las pantallas para evaluar el proyecto
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.greenEmphasis),
            accountName: const Text(
              "Proyecto Final Flutter",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              "a_elisa.rodriguez.villa@iespablopicasso.es",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: Image.asset('images/strength.png'),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: const Text(
                'Se han incluido aquí las pantallas que incluye el proyecto para facilitar la navegación.',
                softWrap: true),
          ),
          ListTile(
            leading: const Icon(
              Icons.login,
            ),
            title: const Text('Inicio de sesión'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.inventory_rounded,
            ),
            title: const Text('Registro'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SigninScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            username: name,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.calculate,
            ),
            title: const Text('Juegos de cálculo (lista)'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameListView(categoria: 'math'),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.menu_book_rounded,
            ),
            title: const Text('Juegos de lengua (lista)'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameListView(categoria: 'language'),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.attach_money_rounded,
            ),
            title: const Text('Juego: Da el cambio (cálculo)'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CambioGame(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
