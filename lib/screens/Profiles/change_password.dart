import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:ask_enzo_app/shared/validators.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/Form/custom_text_form_field.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The `ChangePasswordScreen` class is a stateful widget that allows a user to change their password.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key, required this.user});
  final Tourist user;

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _EditProfileScreenState();
}

/// The `_EditProfileScreenState` class is responsible for rendering the change password screen and
/// handling the logic for updating the user's password.
class _EditProfileScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirmation = TextEditingController();

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    newPasswordConfirmation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        final navigationNotifier = ref.read(navigationProvider.notifier);
        navigationNotifier.pop();
        return false;
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Cambia Password', useLogo: false),
        endDrawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: spacingHeight * 2),
                ProfileImage(
                  name: widget.user.name,
                  surname: widget.user.surname,
                  imgPath: widget.user.imgProfile,
                ),
                const SizedBox(height: spacingHeight * 5),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        obscureText: true,
                        title: 'Vecchia Password',
                        hintText: 'Inserisci la vecchia password',
                        fieldValue: oldPassword,
                        validatorFun: validatePassword,
                        icon: const Icon(FontAwesomeIcons.eyeSlash),
                      ),
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        obscureText: true,
                        title: 'Nuova Password',
                        hintText: 'Inserisci la nuova password',
                        fieldValue: newPassword,
                        validatorFun: validatePassword,
                        icon: const Icon(FontAwesomeIcons.eyeSlash),
                      ),
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        obscureText: true,
                        title: 'Conferma Nuova Password',
                        hintText: 'Conferma la nuova password',
                        fieldValue: newPasswordConfirmation,
                        validatorFun: (value) => validateConfirmationPassword(
                            newPassword.text, value),
                        icon: const Icon(FontAwesomeIcons.eyeSlash),
                      ),
                      const SizedBox(height: 40),
                      CustomElevatedButton(
                          title: 'Cambia Password',
                          fun: () async {
                            ScaffoldMessengerState scaffoldMessenger =
                                ScaffoldMessenger.of(context);

                            if (_formKey.currentState == null) return;
                            if (_formKey.currentState!.validate()) {
                              bool confirmLogout = await showDecisionDialog(
                                context,
                                [
                                  'Modifica Password',
                                  'Sei sicuro di voler aggiornare la password?',
                                  'Annulla',
                                  'Conferma'
                                ],
                              );
                              if (confirmLogout) {
                                if (await apiTouristUpdatePassword(
                                  scaffoldMessenger,
                                  oldPassword: oldPassword.text,
                                  newPassword: newPassword.text,
                                )) {
                                  showCustomSnackBar(scaffoldMessenger,
                                      'Password aggiornata con successo.');
                                }
                              }
                              navigationNotifier.pop();
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
