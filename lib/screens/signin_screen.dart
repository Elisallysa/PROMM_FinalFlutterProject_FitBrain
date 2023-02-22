import 'package:fit_brain/screens/login_screen.dart';
import 'package:fit_brain/screens/screen_widgets/colorBox.dart';
import 'package:fit_brain/screens/screen_widgets/slide_fade_widget.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  // Pantalla de registro de usuarios. Esta pantalla no es funcional porque
  // se ha conseguido escribir en ficheros json desde la aplicación.
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> pinkBoxHeightAnimation;
  late Animation<double> whiteBoxHeightAnimation;
  late Animation<double> opacityAnimation;
  late Animation<double> sizeAnimation;

  late Animation<double> commonFadeSlideAnimation;

  @override
  void initState() {
    super.initState();
    // Se inicializa la animación
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    pinkBoxHeightAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: 1).chain(
              CurveTween(curve: Curves.fastOutSlowIn),
            ),
            weight: 0.25),
        TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 0.41),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1, end: 0.45).chain(
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
                    colorBoxHeightAnimation: pinkBoxHeightAnimation,
                    commonFadeSlideAnimation: commonFadeSlideAnimation,
                    opacityAnimation: opacityAnimation,
                    sizeAnimation: sizeAnimation,
                    riveAnimationPath: 'images/milkshake_adventure.riv',
                    backgroundColor: const Color.fromRGBO(254, 222, 255, 1),
                    title: '¡Registra tu entreno!',
                    textColor: const Color.fromARGB(255, 2, 114, 114),
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

class WhiteBox extends StatelessWidget {
  const WhiteBox({
    Key? key,
    required this.whiteBoxHeightAnimation,
    required this.commonFadeSlideAnimation,
  }) : super(key: key);

  final Animation<double> whiteBoxHeightAnimation;
  final Animation<double> commonFadeSlideAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * whiteBoxHeightAnimation.value +
              6,
      child: SlideFadeWidget(
        commonFadeSlideAnimation: commonFadeSlideAnimation,
        child: const SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // Controladores del input del texto de los TextFields
  var usernameController = TextEditingController();
  var pwdController = TextEditingController();
  var pwdCheckController = TextEditingController();
  // Clave del validador de TextFields
  final formKey = GlobalKey<FormState>();
  // Mensaje para el usuario
  String mensaje = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 2, 114, 114)),
                      ),
                      labelText: 'Nombre de usuario',
                      hintText: 'Introduzca su nombre de usuario'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Introduzca un nombre de usuario.";
                    } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      // Controla que el usuario contenga caracteres alfanuméricos.
                      return "Introduzca un usuario con caracteres alfanuméricos.";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: pwdController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 2, 114, 114)),
                      ),
                      labelText: 'Contraseña',
                      hintText: 'Introduzca su contraseña'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Introduzca una contraseña.";
                    } else if (!value.contains(RegExp(r'\w+\d+'))) {
                      // Controla que la contraseña combine caracteres y números.
                      return 'Debe combinar caracteres y números.';
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pwdCheckController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 2, 114, 114)),
                    ),
                    labelText: 'Confirmar contraseña',
                    hintText: 'Confirme su contraseña'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Introduzca la confirmación de contraseña.";
                  } else if (!value.contains(RegExp(r'\w+\d+'))) {
                    // Controla que la contraseña combine caracteres y números.
                    return 'Debe combinar caracteres y números.';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(254, 222, 255, 1),
                    shape: const ContinuousRectangleBorder(),
                    elevation: 10,
                    shadowColor: const Color.fromARGB(255, 128, 36, 105),
                    fixedSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    if (usernameController.text.isNotEmpty &&
                        pwdCheckController.text.isNotEmpty &&
                        pwdController.text.isNotEmpty) {
                      if (pwdController.text == pwdCheckController.text) {
                        if (formKey.currentState!.validate()) {
                          // Comprueba si los datos son válidos
                          setState(() {
                            mensaje = '';
                          });
                          // Inserta al usuario en el fichero
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        } else {
                          setState(() {
                            mensaje = 'Los campos no son correctos';
                          });
                        }
                      } else {
                        setState(() {
                          mensaje = 'Las contraseñas no coinciden';
                        });
                      }
                    } else {
                      setState(() {
                        mensaje = 'Rellena todos los campos.';
                      });
                    }
                  },
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 114, 114)),
                  )),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  "Volver a Inicio de sesión.",
                  style: TextStyle(color: Color.fromARGB(255, 2, 114, 114)),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                mensaje,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
