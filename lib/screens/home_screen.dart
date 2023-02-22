import 'package:fit_brain/screens/game_cambio.dart';
import 'package:fit_brain/screens/login_screen.dart';
import 'package:fit_brain/screens/screen_widgets/drawer.dart';
import 'package:fit_brain/screens/screen_widgets/emoticono.dart';
import 'package:fit_brain/screens/screen_widgets/game_list_view.dart';
import 'package:fit_brain/screens/signin_screen.dart';
import 'package:fit_brain/theme/fitbrain_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  // Home Screen de Fit Brain
  const HomeScreen({Key? key, required this.username}) : super(key: key);

// Nombre del usuario que ha accedido a la aplicación
  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var nombre = widget.username;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.pinkEmphasis,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '¡Hola, $nombre!',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.person, color: Colors.white),
            )
          ],
        ),
      ),
      drawer: FitBrainDrawer(name: nombre),
      backgroundColor: const Color.fromARGB(255, 214, 242, 235),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '¿Cómo te sientes hoy?',
                style: TextStyle(
                    color: AppTheme.pinkEmphasis,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              // Lista de emojis sin funcionalidad. Están pensados para enviar un
              // mensaje de ánimo al usuario cuando los toca
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Emoticon(emoticono: '😊'),
                Emoticon(emoticono: '😒'),
                Emoticon(emoticono: '😢'),
                Emoticon(emoticono: '😠'),
              ],
            ),
            Padding(
              // Tarjeta en la que se vería el logo/mascota de la aplicación
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 16, bottom: 18),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppTheme.pinkEmphasis, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "¿Entrenamos el\ncerebro?",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.centerRight,
                      child: const Image(
                        image: AssetImage('images/strength.png'),
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Elige una categoría',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppTheme.pinkEmphasis,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Lista de categorías de juegos. Solo son cliclables la de cálculo y lengua
            Card(
                margin: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameListView(
                                  categoria: 'math',
                                )));
                  },
                  child: ListTile(
                    title: const Text('Cálculo mental',
                        style: AppTheme.categoryTitle),
                    subtitle: const Text(
                      "Sumas, restas, multiplicaciones y divisiones",
                      style: AppTheme.categorySubtitle,
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    leading: Image.asset(
                      'images/calculator.png',
                    ),
                  ),
                )),
            Card(
                margin: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameListView(
                                  categoria: 'language',
                                )));
                  },
                  child: ListTile(
                    title: const Text('Lengua', style: AppTheme.categoryTitle),
                    subtitle: const Text("Sinónimos, antónimos y definiciones",
                        style: AppTheme.categorySubtitle),
                    contentPadding: const EdgeInsets.all(10),
                    leading: Image.asset(
                      'images/language-learning.png',
                    ),
                  ),
                )),
            Card(
                margin: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: const Text('Agudeza visual',
                        style: AppTheme.categoryTitle),
                    subtitle: const Text(
                        "Diferencias, formas y percepción espacial",
                        style: AppTheme.categorySubtitle),
                    contentPadding: const EdgeInsets.all(10),
                    leading: Image.asset(
                      'images/eye.png',
                    ),
                  ),
                )),
            Card(
                margin: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: const Text('Memoria', style: AppTheme.categoryTitle),
                    subtitle: const Text(
                        "Listas de palabras, parejas e imágenes",
                        style: AppTheme.categorySubtitle),
                    contentPadding: const EdgeInsets.all(10),
                    leading: Image.asset(
                      'images/memory-game.png',
                    ),
                  ),
                )),
            Card(
                margin: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    title:
                        const Text('Análisis', style: AppTheme.categoryTitle),
                    subtitle: const Text(
                        "Lógica, series numéricas y resolución de problemas",
                        style: AppTheme.categorySubtitle),
                    contentPadding: const EdgeInsets.all(10),
                    leading: Image.asset(
                      'images/analysis.png',
                    ),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
