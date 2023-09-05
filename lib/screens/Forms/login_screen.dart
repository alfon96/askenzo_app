import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/countries.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/PhoneForm/display_flags.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  static const double spacingHeight = 10;

  String _inputEmail = '';
  TextEditingController inputEmail = TextEditingController();
  String _inputPassword = '';
  bool isButtonEnabled = false;
  bool validatedOnce = false;
  bool _isPasswordObscured = true;
  bool _isLoading = false;

  @override
  void dispose() {
    inputEmail.dispose();
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

  void loginFun() async {
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
      bool success = await ref.read(userProvider.notifier).login(
            scaffold,
            email: _inputEmail,
            password: _inputPassword,
          );
      if (success) {
        ref.read(navigationProvider.notifier).pop();
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget getSuffixIcon(int indexField, String fieldName) {
    if (indexField == 0) {
      return LingueFormRegistrazione.mapFieldIcon[fieldName]!;
    } else {
      return GestureDetector(
          onTap: () {
            setState(() {
              _isPasswordObscured = !_isPasswordObscured;
            });
          },
          child: Icon(FontAwesomeIcons.eyeSlash,
              color: _isPasswordObscured
                  ? Configurazione.coloreIconeInactive
                  : Configurazione.coloreIconeActive));
    }
  }

  InputDecoration formStyling(
      int indexField, String fieldName, Languages languageApp) {
    return InputDecoration(
      errorMaxLines: 2,

      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 13,
            color: const Color.fromARGB(255, 255, 0, 0),
          ),

      suffixIcon: getSuffixIcon(indexField, fieldName),
      contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      hintText: LingueFormRegistrazione.linguaSuggerimentiForm[languageApp]
          ?[indexField], // SUGGERIMENTI FORM
    );
  }

  Column titleMaker(index, Languages languageApp) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            LingueFormRegistrazione.linguaCampiForm[languageApp]
                ?[index], // LABEL FORM
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Configurazione.colorePrimario),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    final languageApp = ref.watch(genericProvider)[0];

    return WillPopScope(
      onWillPop: () async {
        navigationNotifier.pushReplacement(homeRoute, arguments: 0);
        return false;
      },
      child: Scaffold(
        endDrawer: const CustomDrawer(),
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Stack(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 36, 46, 56),
                      child: Opacity(
                        opacity: .8,
                        child: Container(
                          height: constraints.maxHeight,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/bckg_login.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Text(LingueFormUserLogin.linguaLogIn[languageApp]!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500)),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Form(
                            key: _formKey,
                            child: Column(children: [
                              // SINGLE FORM FIELD CODE
                              const SizedBox(height: spacingHeight / 2),
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                validator: (email) {
                                  return isEmailValid(email,
                                      languageApp: languageApp);
                                },
                                decoration:
                                    formStyling(0, 'email', languageApp),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (email) {
                                  if (email.isEmpty) {
                                    return;
                                  }
                                  setState(() {
                                    _inputEmail = email.trim();
                                  });
                                },
                              ),
                              const SizedBox(height: spacingHeight),
                              // END SINGLE FORM FIELD CODE
                              // SINGLE FORM FIELD CODE
                              // PASSWORD FIELD
                              const SizedBox(height: spacingHeight / 2),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  validator: (password) {
                                    return isPasswordValid(password);
                                  },
                                  decoration:
                                      formStyling(1, 'password', languageApp),
                                  keyboardType: TextInputType.text,
                                  obscureText: _isPasswordObscured,
                                  onChanged: (password) {
                                    if (password.isEmpty) {
                                      return;
                                    }
                                    setState(() {
                                      _inputPassword = password.trim();
                                    });
                                  },
                                ),
                              ),

                              // END SINGLE FORM FIELD CODE
                            ]),
                          ),
                        ),
                        // FORGOT PASSWORD? CLICK HERE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LingueFormUserLogin
                                  .linguaCampiForm[languageApp]![2],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () => navigationNotifier
                                  .push(recuperoPasswordRoute),
                              child: Text(
                                LingueFormUserLogin
                                    .linguaCampiForm[languageApp]![3],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: spacingHeight),
                        CustomElevatedButton(
                          title: 'Accedi',
                          fun: loginFun,
                          paddingHorizontal: 10.0,
                        ),

                        const SizedBox(height: spacingHeight),
                        // DON'T HAVE ANACCOUNT? SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LingueFormUserLogin
                                  .linguaCampiForm[languageApp]![5],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () =>
                                  navigationNotifier.push(registratiHomeRoute),
                              child: Text(
                                LingueFormUserLogin
                                    .linguaCampiForm[languageApp]![6],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        if (_isLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
