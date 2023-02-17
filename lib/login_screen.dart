import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rive/rive.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> greenBoxHeightAnimation;
  late Animation<double> whiteBoxHeightAnimation;
  late Animation<double> logoOpacityAnimation;
  late Animation<double> logoSizeAnimation;

  late Animation<double> commonFadeSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    greenBoxHeightAnimation = TweenSequence<double>(
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

    logoOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.25, 0.35, curve: Curves.fastOutSlowIn),
      ),
    );
    logoSizeAnimation = Tween<double>(begin: 1, end: 0.5).animate(
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
                  GreenBox(
                    greenBoxHeightAnimation: greenBoxHeightAnimation,
                    commonFadeSlideAnimation: commonFadeSlideAnimation,
                    logoOpacityAnimation: logoOpacityAnimation,
                    logoSizeAnimation: logoSizeAnimation,
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
          MediaQuery.of(context).size.height * whiteBoxHeightAnimation.value,
      child: SlideFadeWidget(
        commonFadeSlideAnimation: commonFadeSlideAnimation,
        child: const LogInForm(),
      ),
    );
  }
}

class LogInForm extends StatelessWidget {
  const LogInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(color: Color.fromRGBO(255, 95, 158, 1)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(151, 196, 184, 1)))),
          ),
          const SizedBox(
            height: 25,
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Color.fromRGBO(255, 95, 158, 1)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(151, 196, 184, 1)))),
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
              onPressed: () {},
              child: const Text(
                'Log In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "¿Nuevo usuario? Regístrate.",
            style: TextStyle(color: Color.fromRGBO(255, 95, 158, 1)),
          ),
        ],
      ),
    );
  }
}

class GreenBox extends StatelessWidget {
  const GreenBox({
    Key? key,
    required this.greenBoxHeightAnimation,
    required this.commonFadeSlideAnimation,
    required this.logoOpacityAnimation,
    required this.logoSizeAnimation,
  }) : super(key: key);

  final Animation<double> greenBoxHeightAnimation;
  final Animation<double> commonFadeSlideAnimation;
  final Animation<double> logoOpacityAnimation;
  final Animation<double> logoSizeAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * greenBoxHeightAnimation.value,
      color: const Color.fromRGBO(151, 196, 184, 1),
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          const Spacer(),
          const Logo(),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideFadeWidget(
              commonFadeSlideAnimation: commonFadeSlideAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text("Iniciar Sesión",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 27)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatefulWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  StateMachineController? controller;
  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      "assets/walk-demo.riv",
      stateMachines: const ["Login Machine"],
      onInit: (artboard) {
        controller =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (controller == null) return;
        artboard.addController(controller!);
      },
    );
  }
}

class SlideFadeWidget extends StatelessWidget {
  const SlideFadeWidget({
    Key? key,
    required this.commonFadeSlideAnimation,
    required this.child,
  }) : super(key: key);

  final Animation<double> commonFadeSlideAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          MediaQuery.of(context).size.width *
              (1 - commonFadeSlideAnimation.value),
          0),
      child: Opacity(
        opacity: commonFadeSlideAnimation.value,
        child: child,
      ),
    );
  }
}
