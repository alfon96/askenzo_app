import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:flutter/material.dart';

/// The `CustomElevatedButton` class is a custom widget in Dart that extends `StatelessWidget` and
/// creates an elevated button with customizable properties such as title, function, font size, padding,
/// and background color.
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.fun,
    this.fontSize = 15.0,
    this.paddingVertical = 0.0,
    this.paddingHorizontal = 0.0,
    this.bkgColor,
  });
  final Function fun;
  final String title;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;
  final Color? bkgColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        fun();
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(bkgColor ?? Configurazione.colorePrimario),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontFamily: Configurazione.fontFamilyBody,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
