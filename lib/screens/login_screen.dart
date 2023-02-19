import 'package:fit_brain/screens/screen_widgets/colorBox.dart';
import 'package:fit_brain/screens/screen_widgets/slide_fade_widget.dart';
import 'package:fit_brain/screens/signin_screen.dart';
import 'package:fit_brain/utils/json_util.dart';
import 'package:fit_brain/utils/login_validator.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../models/usuario.dart';

// Pantalla de Log in. Busca en la BD del fichero json el usuario y contraseña
// para permitir el acceso a la aplicación.
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // ATRIBUTOS DEL ESTADO
  // Controladores de la animación
  late AnimationController _animationController;
  late Animation<double> colorBoxHeightAnimation;
  late Animation<double> whiteBoxHeightAnimation;
  late Animation<double> opacityAnimation;
  late Animation<double> sizeAnimation;
  late Animation<double> commonFadeSlideAnimation;

  @override
  void initState() {
    super.initState();
    // Se inicializan los valores de la animación
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    colorBoxHeightAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: 1).chain(
              CurveTween(curve: Curves.fastOutSlowIn),
            ),
            weight: 0.25),
        TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 0.41),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1, end: 0.5).chain(
              CurveTween(curve: Curves.decelerate),
            ),
            weight: 0.33),
      ],
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.75),
      ),
    );

    whiteBoxHeightAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.75, curve: Curves.decelerate),
      ),
    );

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.25, 0.35, curve: Curves.fastOutSlowIn),
      ),
    );
    sizeAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.75, curve: Curves.decelerate),
      ),
    );

    commonFadeSlideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.65, 0.9, curve: Curves.decelerate),
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ColorBox(
                    colorBoxHeightAnimation: colorBoxHeightAnimation,
                    commonFadeSlideAnimation: commonFadeSlideAnimation,
                    opacityAnimation: opacityAnimation,
                    sizeAnimation: sizeAnimation,
                    riveAnimationPath: 'images/zorrito.riv',
                    backgroundColor: const Color.fromRGBO(151, 196, 184, 1),
                    title: 'Iniciar sesión',
                    textColor: Colors.white,
                  ),
                  WhiteBox(
                    whiteBoxHeightAnimation: whiteBoxHeightAnimation,
                    commonFadeSlideAnimation: commonFadeSlideAnimation,
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class WhiteBox extends StatefulWidget {
// Componente donde se encuentran los TextFields y el botón de Inicio de sesión.
// Recibe como parámetros los valores para la animación
// del mismo al inicio de la aplicación
  final Animation<double> whiteBoxHeightAnimation;
  final Animation<double> commonFadeSlideAnimation;
  // Lista de usuarios almacenados en el archivo json
  List<Usuario>? usuarios;

  WhiteBox({
    Key? key,
    required this.whiteBoxHeightAnimation,
    required this.commonFadeSlideAnimation,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WhiteBoxState();
}

class _WhiteBoxState extends State<WhiteBox> {
  // ATRIBUTOS DEL ESTADO:
  // Lista de usuarios almacenados en el fichero json
  List<Usuario>? usuarios;
  // Controladores de los TextFields
  final usernameController = TextEditingController();
  final pwdController = TextEditingController();
  // Indica si se ha cargado la lista de usuarios
  var isLoaded = false;
  // Indica si el usuario o contraseña son correctos
  var wrongCredentials = false;

  getData() async {
    // Obtiene los datos de los usuarios almacenados en el fichero json y los
    // almacena en el atributo "usuarios" del _WhiteBoxState
    usuarios = await JsonUtil().readLocalJson('database/users.json');
    if (usuarios != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //En la inicialización del estado, se obtiene la lista de usuarios
    getData();
  }

  @override
  void dispose() {
    // Limpia los controladores cuando se detiene el Widget
    usernameController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          widget.whiteBoxHeightAnimation.value,
      child: SlideFadeWidget(
        commonFadeSlideAnimation: widget.commonFadeSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromRGBO(255, 95, 158, 1)),
                    ),
                    labelText: 'Nombre de usuario',
                    hintText: 'Introduzca su nombre de usuario'),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: pwdController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromRGBO(255, 95, 158, 1)),
                    ),
                    labelText: 'Contraseña',
                    hintText: 'Introduzca su contraseña'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(151, 196, 184, 1),
                    shape: const ContinuousRectangleBorder(),
                    elevation: 10,
                    shadowColor: const Color.fromARGB(255, 128, 36, 105),
                    fixedSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    if (LoginValidation(usuarios!,
                            username: usernameController.text,
                            password: pwdController.text)
                        .isRegistered()) {
                      // Si el usuario y contraseña se encuentran en la bd
                      // se permite el acceso a la aplicación
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninScreen()));
                    } else {
                      setState(() {
                        wrongCredentials = true;
                      });
                    }
                  },
                  child: const Text(
                    'Acceder',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              // Widget que detecta gestos en su widget hijo. En este caso, un Text
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninScreen()));
                },
                child: const Text(
                  "¿Nuevo usuario? Regístrate",
                  style: TextStyle(color: Color.fromRGBO(255, 95, 158, 1)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: wrongCredentials,
                child: const Text(
                  'Usuario o contraseña erróneos.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
