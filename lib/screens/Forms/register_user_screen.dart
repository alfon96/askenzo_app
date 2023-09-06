import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/countries.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/shared/form_functions.dart';
import 'package:ask_enzo_app/shared/validators.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/Form/custom_text_form_field.dart';
import 'package:ask_enzo_app/widgets/PhoneForm/display_flags.dart';
import 'package:ask_enzo_app/widgets/waiting/custom_waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

Map<String, Color> colorMap = <String, Color>{
  'formFieldTitleColor': Colors.blue,
  'formFieldInputColor': Colors.black,
};

/// The RegisterUserScreen class is a stateful widget that extends ConsumerStatefulWidget.
class RegisterUserScreen extends ConsumerStatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  ConsumerState<RegisterUserScreen> createState() => _RegisterScreenState();
}

/// The `_RegisterScreenState` class is responsible for managing the state and UI of the registration
/// screen in a Flutter app.
class _RegisterScreenState extends ConsumerState<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  static const double spacingHeight = 20;
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputRepeatedPassword = TextEditingController();
  TextEditingController inputNome = TextEditingController();
  TextEditingController inputCognome = TextEditingController();
  TextEditingController inputPhoneNumber = TextEditingController();
  bool isButtonEnabled = false;
  bool validatedOnce = false;
  bool _isPrivacyChecked = false;
  bool _isLoading = false;

  @override
  void dispose() {
    inputNome.dispose();
    inputCognome.dispose();
    inputEmail.dispose();
    inputPhoneNumber.dispose();
    inputPassword.dispose();
    inputRepeatedPassword.dispose();
    super.dispose();
  }

  Future<Country> showDialogWithData(BuildContext context) {
    final completer = Completer<Country>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DisplayFlagsPhoneCode();
      },
    );
    return completer.future;
  }

  void showCustomDialog(BuildContext context) async {
    await showDialogWithData(context);
  }

  void registerUserBtn(selectedCountry, navigationNotifier) {
    if (_formKey.currentState!.validate()) {
      {
        _saveItem(selectedCountry, navigationNotifier);
      }
    } else {
      if (!validatedOnce) {
        validatedOnce = true;
      }
      _formKey.currentState!.validate();
    }
  }

  void _saveItem(Country selectedCountry, navigationNotifier) async {
    setState(() {
      _isLoading = true;
    });
    TouristRegister tourist = TouristRegister(
      name: inputNome.text,
      surname: inputCognome.text,
      password: inputPassword.text,
      telephone: selectedCountry.dialCode + inputPhoneNumber.text,
      email: inputEmail.text,
      imgProfile: 'null',
      stateId: 1,
    );
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    await saveItem(scaffold, tourist, null, navigationNotifier);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    final selectedCountry = ref.watch(genericProvider)[1];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Registrati'),
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SingleChildScrollView(
          child: CustomWaitingWidget(
            isWaiting: _isLoading,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: spacingHeight * 2),
                  CustomTextFormField(
                    obscureText: false,
                    title: 'Email *',
                    hintText: 'es. askenzo@gmail.com',
                    fieldValue: inputEmail,
                    validatorFun: validateEmail,
                    icon: const Icon(Icons.mail),
                    iconBtnFun: () {},
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: spacingHeight),
                  CustomTextFormField(
                    obscureText: true,
                    title: 'Password *',
                    hintText: 'Password11',
                    fieldValue: inputPassword,
                    validatorFun: validatePassword,
                    icon: const Icon(FontAwesomeIcons.eyeSlash),
                  ),
                  const SizedBox(height: spacingHeight),
                  CustomTextFormField(
                    obscureText: true,
                    title: 'Conferma Password *',
                    hintText: 'Password11',
                    fieldValue: inputRepeatedPassword,
                    validatorFun: (value) =>
                        validateConfirmationPassword(inputPassword.text, value),
                    icon: const Icon(FontAwesomeIcons.eyeSlash),
                  ),
                  Text(
                    'La tua password deve avere: almeno 8 caratteri, almeno una lettera maiuscola e una minuscola, almeno due numeri.',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Configurazione.colorePrimario),
                  ),
                  const SizedBox(height: spacingHeight),
                  CustomTextFormField(
                    obscureText: false,
                    title: 'Nome *',
                    hintText: 'Enzo',
                    fieldValue: inputNome,
                    validatorFun: validateUsername,
                    icon: const Icon(Icons.person),
                    iconBtnFun: () {},
                  ),
                  const SizedBox(height: spacingHeight),
                  CustomTextFormField(
                    obscureText: false,
                    title: 'Cognome *',
                    hintText: 'Rossi',
                    fieldValue: inputCognome,
                    validatorFun: validateUsername,
                    icon: const Icon(Icons.person),
                    iconBtnFun: () {},
                  ),
                  const SizedBox(height: spacingHeight),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      width: 85,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 40,
                            child: GestureDetector(
                              onTap: () {
                                showCustomDialog(context);
                              },
                              child: Image.asset(
                                  'assets/flags/${selectedCountry.code.toLowerCase()}.png',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '+${selectedCountry.dialCode}',
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    title: CustomTextFormField(
                      obscureText: false,
                      title: 'Telefono',
                      hintText: 'es. 371184598',
                      fieldValue: inputPhoneNumber,
                      validatorFun: validatePhone,
                      icon: const Icon(Icons.smartphone),
                      iconBtnFun: () {},
                    ),
                  ),
                  const SizedBox(height: spacingHeight),
                  FormField(
                    initialValue: _isPrivacyChecked,
                    validator: (value) {
                      if (value == false) {
                        return 'È necessario accettare le condizioni di Privacy.';
                      }
                      return null;
                    },
                    builder: (FormFieldState<bool> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _isPrivacyChecked,
                            onChanged: (value) {
                              setState(() {
                                _isPrivacyChecked = !_isPrivacyChecked;
                              });
                              field.didChange(value);
                            },
                            title: Text(
                              'Creando un account, accetti i nostri Termini di servizio e la Dichiarazione sulla privacy e sui cookie.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Configurazione.colorePrimario),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          // Display the error message
                          field.errorText == null
                              ? const SizedBox.shrink()
                              : Center(
                                  child: Text(
                                    field.errorText!,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: spacingHeight * 3),
                  CustomElevatedButton(
                    title: 'Registrati',
                    fun: () =>
                        registerUserBtn(selectedCountry, navigationNotifier),
                    paddingHorizontal: 45.0,
                    paddingVertical: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
