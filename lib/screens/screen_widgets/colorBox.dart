import 'package:fit_brain/screens/screen_widgets/slide_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ColorBox extends StatelessWidget {
  const ColorBox(
      {Key? key,
      required this.colorBoxHeightAnimation,
      required this.commonFadeSlideAnimation,
      required this.opacityAnimation,
      required this.sizeAnimation,
      required this.riveAnimationPath,
      required this.backgroundColor,
      required this.textColor,
      required this.title})
      : super(key: key);

  final Animation<double> colorBoxHeightAnimation;
  final Animation<double> commonFadeSlideAnimation;
  final Animation<double> opacityAnimation;
  final Animation<double> sizeAnimation;
  final String riveAnimationPath;
  final Color backgroundColor;
  final Color textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * colorBoxHeightAnimation.value,
      color: backgroundColor,
      alignment: Alignment.center,
      child: SlideFadeWidget(
        commonFadeSlideAnimation: commonFadeSlideAnimation,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
                height: 300, child: RiveAnimation.asset(riveAnimationPath)),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 27)),
          ],
        ),
      ),
    );
  }
}
