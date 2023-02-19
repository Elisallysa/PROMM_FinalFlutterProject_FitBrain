import 'package:flutter/material.dart';

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
