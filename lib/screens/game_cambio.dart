import 'package:fit_brain/models/pago_cambio_game.dart';
import 'package:fit_brain/screens/screen_widgets/drawer.dart';
import 'package:fit_brain/screens/screen_widgets/game_list_view.dart';
import 'package:fit_brain/theme/fitbrain_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import '../utils/json_util.dart';

class CambioGame extends StatefulWidget {
  // Juego Da el cambio. El juego consiste en hacer una simulación en la que el
  // usuario se convierte en vendedor y debe dar el cambio correcto a su cliente.
  const CambioGame({Key? key}) : super(key: key);

  @override
  State<CambioGame> createState() => _CambioGameState();
}

class _CambioGameState extends State<CambioGame> {
  // Atributos del estado
  List<CambioPago>? rondas;
  bool isLoaded = false;
  String euro5 = 'images/e5.png';
  String euro2 = 'images/e2.png';
  String euro1 = 'images/e1.png';
  String coin1 = '';
  String coin2 = '';
  String coin3 = '';
  double change = 0;
  double price = 0;
  double precio = 0;
  double pay = 0;
  double puntuacion = 0;
  int numRondas = 0;
  bool isCorrect = true;
  Color colorCambio = Colors.black;

  void increaseChange(double amount) {
    setState(() {
      change += amount;
    });
  }

  Future<void> _instructionsDialog() async {
    // Cuadro de diálogo que aparece al iniciarse la vista.
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Es obligatorio que se pulse el botón
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Da el cambio', style: AppTheme.alertaTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Observa arriba la cantidad que te debe el cliente y la cantidad que te da.',
                ),
                Text(
                  'Toca las monedas para sumar el cambio correcto.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('¡Entrenar!', style: AppTheme.categoryTitle),
              onPressed: () {
                getRound();
                Navigator.pop(context, '¡Entrenar!');
              },
            ),
          ],
        );
      },
    );
  }

  getData() async {
    // Obtiene los datos de las posibilidades de pago almacenados en el fichero json y los
    // almacena en el atributo "rondas" de _CambioGameState
    rondas = await JsonUtil().readCambioGameJson('database/cambio_game.json');
    if (rondas != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  setPriceAndCoins(
      // Setea la cantidad que da el cliente (pago), el precio que se debe pagar,
      // y las imágenes de los billetes y/o monedas que da el cliente (pago)
      double pago,
      double precio,
      String mon1,
      String mon2,
      String mon3) {
    setState(() {
      pay = pago;
      coin1 = mon1;
      coin2 = mon2;
      coin3 = mon3;
      price = precio;
      change = 0;
    });
  }

  double getPrice(int minQ, int maxQ) {
    // Genera un precio aleatorio
    return Random().nextDouble() * (maxQ - minQ) + minQ;
  }

  getRound() {
    // Genera una ronda nueva con un precio y un pago nuevos
    change = 0;
    int option = Random().nextInt(5);
    CambioPago ronda = rondas!.elementAt(option);
    precio = getPrice(ronda.preciomin, ronda.preciomax).toPrecision(2);
    switch (option) {
      case 0:
        {
          setPriceAndCoins(1, precio, euro1, '', '');
        }
        break;

      case 1:
        {
          setPriceAndCoins(2, precio, euro2, '', '');
        }
        break;

      case 2:
        {
          setPriceAndCoins(5, precio, euro5, '', '');
        }
        break;

      case 3:
        {
          setPriceAndCoins(7, precio, euro5, euro2, '');
        }
        break;
      case 4:
        {
          setPriceAndCoins(9, precio, euro5, euro2, euro2);
        }
        break;
      default:
        {
          setPriceAndCoins(0, 0, '', '', '');
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    // Salta un cuadro de diálogo al iniciar la aplicación
    WidgetsBinding.instance.addPostFrameCallback((_) => _instructionsDialog());
    // Se obtienen los datos para crear las rondas de juego
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FitBrainDrawer(name: 'user'),
      backgroundColor: AppTheme.palePink,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppTheme.tile,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                height: 50,
                child: const Text(
                  'Da la vuelta',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    color: AppTheme.greenEmphasis,
                    border: Border.all(color: AppTheme.greenEmphasis),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('€',
                          style: GoogleFonts.orbitron(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 26))),
                      Text(price.toStringAsFixed(2),
                          // Texto del precio con 2 decimales
                          style: GoogleFonts.orbitron(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 26))),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 210,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: coin1.isNotEmpty,
                        child: SizedBox(width: 140, child: Image.asset(coin1))),
                    Column(
                      children: [
                        Visibility(
                          visible: coin2.isNotEmpty,
                          child: SizedBox(
                              width: 140,
                              height: 90,
                              child: Image.asset(coin2)),
                        ),
                        Visibility(
                          visible: coin3.isNotEmpty,
                          child: SizedBox(
                              width: 140,
                              height: 90,
                              child: Image.asset(coin3)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                color: AppTheme.tile,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  children: [
                    GestureDetector(
                        onTap: () {
                          increaseChange(1);
                        },
                        child: Image.asset('images/e1.png')),
                    GestureDetector(
                        onTap: () {
                          increaseChange(0.5);
                        },
                        child: Image.asset('images/50.png')),
                    GestureDetector(
                        onTap: () {
                          increaseChange(0.2);
                        },
                        child: Image.asset('images/20.png')),
                    GestureDetector(
                        onTap: () {
                          increaseChange(0.1);
                        },
                        child: Image.asset('images/10.png')),
                    GestureDetector(
                        onTap: () {
                          increaseChange(0.05);
                        },
                        child: Image.asset('images/5.png')),
                    GestureDetector(
                        onTap: () {
                          increaseChange(0.01);
                        },
                        child: Image.asset('images/1.png')),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    color: AppTheme.greenEmphasis,
                    border: Border.all(color: AppTheme.greenEmphasis),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('€',
                          style: GoogleFonts.orbitron(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 26))),
                      Text(change.toStringAsFixed(2),
                          // Texto del cambio con 2 decimales
                          style: GoogleFonts.orbitron(
                              textStyle: TextStyle(
                                  color: isCorrect ? Colors.white : Colors.red,
                                  fontSize: 26))),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Ink(
                  // Botón de borrar
                  decoration: const ShapeDecoration(
                    color: AppTheme.tile,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    iconSize: 40,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          change = 0;
                        },
                      );
                    },
                  ),
                ),
                Ink(
                  // Botón de enviar
                  decoration: const ShapeDecoration(
                    color: AppTheme.tile,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 40,
                    icon: const Icon(
                      Icons.check,
                    ),
                    onPressed: () {
                      if (change + price == pay) {
                        // Si el cambio es correcto se crea una nueva ronda y se suman 50 puntos
                        isCorrect = true;
                        if (numRondas == 4) {
                          // Cuando se llega a la 5 ronda, el juego se termina
                          // y aparece un AlertDialog con la puntuación
                          setState(
                            () {
                              puntuacion += 50;
                            },
                          );
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('¡Muy bien!'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      const Text('Has terminado las 5 rondas.'),
                                      Text(
                                          'Tu puntuación ha sido: $puntuacion'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GameListView(
                                                categoria: 'math'))),
                                    child: const Text('Terminar'),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      setState(() {
                                        puntuacion = 0;
                                        price = 0;
                                        numRondas = 0;
                                        getRound();
                                      }),
                                      Navigator.pop(context, '¡Otra!')
                                    },
                                    child: const Text('¡Otra!'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Si todavía no se ha llegado a la 5ª ronda, se suma
                          // la puntuación y se hace una nueva ronda
                          setState(
                            () {
                              puntuacion += 50;
                              numRondas++;
                              getRound();
                            },
                          );
                        }
                      } else {
                        // Si el cambio no es correcto, se restan dos puntos
                        // el cambio se coloreará de rojo
                        setState(
                          () {
                            isCorrect = false;
                            puntuacion -= 20;
                          },
                        );
                      }
                    },
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}

extension Ex on double {
  // Transforma un double para que tenga solo 2 decimales
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
