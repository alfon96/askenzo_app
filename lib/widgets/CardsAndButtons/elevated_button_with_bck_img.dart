import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/configurazione.dart';

class ElevatedButtonBackground extends StatelessWidget {
  const ElevatedButtonBackground({
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
/// The DiscoverItemCard class is a stateful widget that displays information about a discovery item.
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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: btnBackgroundColor, boxShadow: const [
        BoxShadow(
          color: Configurazione.colorePrimario,
          blurStyle: BlurStyle.solid,
          blurRadius: 2,
        ),
      ]),
      child: Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: Image.asset(
              backgroundImagePath,
              fit: BoxFit.cover,
              height: height,
            ),
          ),
          // Positioned(
          //   bottom: 7,
          //   top: height * .85,
          //   right: 20,
          //   left: 20,
          //   child: Container(
          //     padding: const EdgeInsets.all(1),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         btnFunction();
          //       },
          //       child: Text(btnText),
          //       // style: ElevatedButton.styleFrom(
          //       //     tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 45,
            child: Image.asset('assets/images/logo/logo_ask_enzo.png',
                height: height * .7),
          ),
        ],
      ),
    );
  }
}
