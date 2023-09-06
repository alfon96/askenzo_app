import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ask_enzo_app/data/lingue.dart';
/// The `CustomDrawerButton` class is a Dart widget that represents a button in a custom drawer, with
/// customizable properties such as page navigation, button name, icon, and additional functionality.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});
  static const double borderRadiusSnackBar = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageApp = ref.watch(genericProvider)[0];
    final bool isLoggedIn = ref.watch(userProvider)[0] != null;
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return Drawer(
      width: 200,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            isLoggedIn
                ? CustomDrawerButton(
                    logOut: true,
                    logOutText: LingueDrawer.linguaLogOut[languageApp]!,
                    page: '',
                    btnName: LingueDrawer.opzioni[languageApp]![5],
                    icon: Icons.logout,
                  )
                : CustomDrawerButton(
                    additionalFun: () {
                      navigationNotifier.pop();
                      navigationNotifier.push(loginRoute);
                    },
                    page: loginRoute,
                    btnName: LingueDrawer.opzioni[languageApp]![0],
                    icon: Icons.login,
                  ),
            isLoggedIn
                ? const SizedBox(height: 1)
                : CustomDrawerButton(
                    page: registratiHomeRoute,
                    btnName: LingueDrawer.opzioni[languageApp]![1],
                    icon: FontAwesomeIcons.userPlus,
                  ),
            // CustomDrawerButton(
            //   page: aboutUsRoute,
            //   btnName: LingueDrawer.opzioni[languageApp]![2],
            //   icon: FontAwesomeIcons.addressCard,
            // ),
            // CustomDrawerButton(
            //   page: privacyRoute,
            //   btnName: LingueDrawer.opzioni[languageApp]![3],
            //   icon: FontAwesomeIcons.lock,
            // ),
            // CustomDrawerButton(
            //   page: terminiUsoRoute,
            //   btnName: LingueDrawer.opzioni[languageApp]![4],
            //   icon: FontAwesomeIcons.file,
            // ),
            const Spacer(),
            // DropdownButton<Languages>(
            //   underline: Container(),
            //   value: ref.watch(genericProvider)[0],
            //   onChanged: (Languages? newValue) {
            //     if (newValue != languageApp) {
            //       final wasChanged = ref
            //           .read(genericProvider.notifier)
            //           .toggleLanguageChoice(newValue!);
            //       if (wasChanged) {
            //         ScaffoldMessenger.of(context).clearSnackBars();
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             shape: snackBarShape(),
            //             backgroundColor: const Color.fromARGB(255, 1, 23, 41),
            //             duration: const Duration(seconds: 2),
            //             content: SizedBox(
            //               height: 35,
            //               child: Center(
            //                   child: Text(
            //                 LingueDrawer.linguaAggiornata[newValue]!,
            //                 textAlign: TextAlign.center,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodyMedium!
            //                     .copyWith(
            //                       color: Colors.white,
            //                     ),
            //               )),
            //             ),
            //           ),
            //         );
            //         navigationNotifier.pop(context);
            //       }
            //     }
            //   },
            //   items: Languages.values.map((Languages language) {
            //     return DropdownMenuItem<Languages>(
            //       value: language,
            //       child: SizedBox(
            //         height: 30,
            //         width: 120,
            //         child: Row(
            //           children: [
            //             _buildIcon(language),
            //             const SizedBox(width: 10),
            //             Text(
            //               language.toString().split('.')[1].capitalize(),
            //               style: Theme.of(context).textTheme.bodyMedium,
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   }).toList(),
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
