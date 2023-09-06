import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/// The `CustomDrawerButton` class is a Dart widget that represents a button in a custom drawer, with
/// customizable properties such as page navigation, button name, icon, icon color, additional function,
/// logout functionality, and logout text.

class CustomDrawerButton extends ConsumerWidget {
  const CustomDrawerButton({
    Key? key,
    required this.page,
    required this.btnName,
    required this.icon,
    this.iconColor = Configurazione.colorePrimario,
    this.additionalFun,
    this.logOut = false,
    this.logOutText = const [],
  }) : super(key: key);

  final String page;
  final String btnName;
  final IconData icon;
  final Color iconColor;
  final Function()? additionalFun;
  final bool logOut;
  final List<String> logOutText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    return InkWell(
      onTap: () async {
        if (additionalFun == null) {
          if (logOut) {
            bool confirmLogout = await showDecisionDialog(context, logOutText);
            if (confirmLogout) {
              navigationNotifier.pop();
              ref.read(userProvider.notifier).logout();
              ref.read(navigationProvider.notifier).pushReplacement(homeRoute);
            }
            navigationNotifier.pop();
          } else {
            navigationNotifier.pop();
            navigationNotifier.push(page);
          }
        } else {
          additionalFun?.call();
          //navigationNotifier.pop();
        }
      },
      child: ListTile(
        leading: FaIcon(
          icon,
          color: iconColor,
        ),
        title: Text(
          btnName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
