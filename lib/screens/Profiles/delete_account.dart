import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/shared/validators.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/Form/custom_text_form_field.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The `DeleteProfile` class is a Dart widget that displays a screen for deleting a user's account,
/// including a password input field and a button to confirm the deletion.
class DeleteProfile extends ConsumerWidget {
  const DeleteProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteAccount(String password) {
      ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
      apiTouristDeleteMe(scaffold, password: password);
      // Il logout serve solo per cancellare il jwt.
      ref.read(userProvider.notifier).logout();
      ref.read(navigationProvider.notifier).pushReplacement(homeRoute);
    }

    TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Elimina Account',
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              text: 'Rimozione Account',
              isTitle: true,
              fontSize: 30,
              color: Configurazione.colorePrimario,
            ),
            const SizedBox(height: spacingHeight * 2),
            const CustomText(
              text:
                  'Questa azione cancellerà tutti i tuoi dati dal nostro database e non sarà più possibile tornare indietro.\nSe sei sicuro, inserisci la tua password e clicca su "elimina account".',
              color: Colors.red,
            ),
            const SizedBox(height: spacingHeight * 2),
            CustomTextFormField(
              obscureText: true,
              title: 'Password *',
              hintText: 'Password11',
              validatorFun: validatePassword,
              icon: const Icon(FontAwesomeIcons.eyeSlash),
              fieldValue: password,
            ),
            const SizedBox(height: spacingHeight * 4),
            CustomElevatedButton(
              title: 'Elimina Account',
              fun: () => deleteAccount(password.text),
              bkgColor: const Color.fromARGB(255, 255, 72, 0),
            )
          ],
        ),
      ),
    );
  }
}
