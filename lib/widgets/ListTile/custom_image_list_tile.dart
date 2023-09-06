import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomImageListTile extends ConsumerWidget {
  const CustomImageListTile({
    super.key,
/// The `FieldAccount` class is a Dart widget that represents a clickable ListTile with a custom text
/// and icon, used for navigating to different routes in an app.
    required this.imgPath,
    required this.width,
    required this.text,
    this.textColor = Colors.black,
    this.iconColor = Configurazione.colorePrimario,
  });

  final String imgPath;
  final String text;
  final double width;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Image.asset(
        imgPath,
        width: width,
        fit: BoxFit.cover,
      ),
      title: CustomText(
        text: text,
      ),
    );
  }
}
