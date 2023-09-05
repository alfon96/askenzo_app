import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/configurazione.dart';

class TextButtonBackground extends StatelessWidget {
  const TextButtonBackground({
    super.key,
    required this.height,
    required this.width,
    required this.backgroundImagePath,
    required this.btnFunction,
    required this.btnText,
    required this.opacity,
    this.btnBackgroundColor = Configurazione.coloreBackgroundPulsanti,
    this.btnFontColor = Configurazione.coloreFontPulsanti,
    this.borderRadius = 15.0,
    this.fontSize = Configurazione.fontSizeBodyLarge,
  });

  final double height;
  final double width;
  final String backgroundImagePath;
  final String btnText;
  final Function btnFunction;
  final double opacity;
  final Color btnBackgroundColor;
  final Color btnFontColor;
  final double fontSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final brdRadius = BorderRadius.circular(borderRadius);

    return ClipRRect(
      borderRadius: borderRadius > 0
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.circular(0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: btnBackgroundColor,
            borderRadius: brdRadius,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2,
              ),
            ]),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: opacity,
              child: ClipRRect(
                borderRadius: brdRadius,
                child: Image.asset(
                  backgroundImagePath,
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Image.asset('assets/images/logo/logo_ask_enzo.png',
                  height: height * 1.85),
            ),
            TextButton(
                onPressed: () {
                  btnFunction();
                },
                child: CustomText(
                  text: '           $btnText',
                  color: Colors.white,
                  fontSize: fontSize,
                  alignment: TextAlign.end,
                )),
          ],
        ),
      ),
    );
  }
}
