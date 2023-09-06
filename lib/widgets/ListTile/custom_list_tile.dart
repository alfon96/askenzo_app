import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';

import 'package:ask_enzo_app/widgets/custom_text.dart';
/// The `CustomImageListTile` class is a custom widget that displays an image and text in a ListTile.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FieldAccount extends ConsumerWidget {
  const FieldAccount({
    super.key,
    required this.route,
    required this.text,
    required this.icon,
    this.textColor = Colors.black,
    this.iconColor = Configurazione.colorePrimario,
    required this.user,
  });

  final String route;
  final String text;
  final Color textColor;
  final Color iconColor;
  final IconData icon;
  final Tourist? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    return InkWell(
      onTap: () {
        if (user != null) {
          navigationNotifier.push(route, arguments: user);
        } else {
          navigationNotifier.push(route);
        }
      },
      child: ListTile(
        title: CustomText(
          text: text,
          color: textColor,
          fontSize: 15,
        ),
        trailing: Icon(icon, color: iconColor),
      ),
    );
  }
}
