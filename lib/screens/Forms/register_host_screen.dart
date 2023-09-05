import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/countries.dart';
import 'package:ask_enzo_app/models/host.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/shared/form_functions.dart';
import 'package:ask_enzo_app/shared/validators.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/Form/custom_text_form_field.dart';
import 'package:ask_enzo_app/widgets/PhoneForm/display_flags.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:ask_enzo_app/widgets/waiting/custom_waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';

class RegisterHostScreen extends ConsumerStatefulWidget {
  const RegisterHostScreen({super.key});

  @override
  ConsumerState<RegisterHostScreen> createState() => _RegisterHostScreenState();
}

class _RegisterHostScreenState extends ConsumerState<RegisterHostScreen> {
  final _formKey = GlobalKey<FormState>();
  static const double spacingHeight = 15;

  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputRepeatedPassword = TextEditingController();
  TextEditingController inputNome = TextEditingController();
  bool isButtonEnabled = false;
  bool validatedOnce = false;
  bool _isLoading = false;

  @override
  void dispose() {
    inputEmail.dispose();
    inputPassword.dispose();
    inputRepeatedPassword.dispose();
    inputNome.dispose();
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

  void checkButtonEnabling() {
    isButtonEnabled = false;
  }

  void registerHostBtn(navigationNotifier) {
    if (_formKey.currentState!.validate()) {
      _saveItem(navigationNotifier);
    } else {
      if (!validatedOnce) {
        validatedOnce = true;
      }
      _formKey.currentState!.validate();
    }
  }

  Future<void> _saveItem(navigationNotifier) async {
    setState(() {
      _isLoading = true;
    });
    HostRegister host = HostRegister(
      name: inputNome.text,
      password: inputPassword.text,
      email: inputEmail.text,
      imgProfile: '',
      stateId: 1,
    );
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    await saveItem(scaffold, null, host, navigationNotifier);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageApp = ref.watch(genericProvider)[0];
    final navigationNotifier = ref.read(navigationProvider.notifier);
    return Scaffold(
      appBar:
          CustomAppBar(title: LingueFormRegistrazione.registrati[languageApp]!),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: CustomWaitingWidget(
          isWaiting: _isLoading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 400,
                child: Stack(children: [
                  Container(
                    color: const Color.fromARGB(255, 10, 10, 10),
                  ),
                  Opacity(
                    opacity: .75,
                    child: Image.asset(
                      width: double.infinity,
                      'assets/images/primo_avvio/slider_5.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LingueFormRegistrazioneHost
                                .linguaTitoliForm[languageApp]![0],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            LingueFormRegistrazioneHost
                                .linguaTitoliForm[languageApp]![1],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: spacingHeight * 2,
                    ),
                    const CustomText(
                      contentPaddingL: 20,
                      contentPaddingR: 20,
                      text: '1 Crea il tuo account',
                      isTitle: true,
                      color: Configurazione.colorePrimario,
                    ),
                    const CustomText(
                      contentPaddingL: 20,
                      contentPaddingR: 20,
                      text:
                          'Iscriviti e registra il tuo profilo. Inizia subito a compilare la tua domanda per entrare nel circuito.',
                      color: Configurazione.colorePrimario,
                    ),
                    const SizedBox(
                      height: spacingHeight,
                    ),
                    const CustomText(
                      contentPaddingL: 20,
                      contentPaddingR: 20,
                      text: '2 Compila tutti i campi',
                      color: Configurazione.colorePrimario,
                      isTitle: true,
                    ),
                    const CustomText(
                      contentPaddingL: 20,
                      contentPaddingR: 20,
                      color: Configurazione.colorePrimario,
                      text:
                          'Completa tutti i passaggi ed è fatta! Il nostro team ti contatterà.',
                    ),
                    const SizedBox(
                      height: spacingHeight * 2,
                    ),
                    const SizedBox(height: spacingHeight / 2),
                    CustomTextFormField(
                      contentPaddingL: 20,
                      contentPaddingR: 20,
                      obscureText: false,
                      title: 'Nome',
                      hintText: 'es. B&B Askenzo',
                      fieldValue: inputNome,
                      validatorFun: validateUsername,
                      icon: const Icon(Icons.home),
                      iconBtnFun: () {},
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomTextFormField(
                      contentPaddingL: 20,
                      contentPaddingR: 20,
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
                      contentPaddingL: 20,
                      contentPaddingR: 20,
                      obscureText: true,
                      title: 'Password *',
                      hintText: 'Password11',
                      fieldValue: inputPassword,
                      validatorFun: validatePassword,
                      icon: const Icon(FontAwesomeIcons.eyeSlash),
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomTextFormField(
                      contentPaddingL: 20,
                      contentPaddingR: 20,
                      obscureText: true,
                      title: 'Conferma Password *',
                      hintText: 'Password11',
                      fieldValue: inputRepeatedPassword,
                      validatorFun: (value) => validateConfirmationPassword(
                          inputPassword.text, value),
                      icon: const Icon(FontAwesomeIcons.eyeSlash),
                    ),
                    const SizedBox(height: spacingHeight),
                    const CustomText(
                      contentPaddingL: 20,
                      text:
                          'La tua password deve avere: almeno 8 caratteri, almeno una lettera maiuscola e una minuscola, almeno due numeri.',
                      fontSize: 11.5,
                      color: Configurazione.colorePrimario,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: spacingHeight),
              CustomElevatedButton(
                title: 'Registrati',
                fun: () => registerHostBtn(navigationNotifier),
              ),
              const SizedBox(height: spacingHeight),
            ],
          ),
        ),
      ),
    );
  }
}
