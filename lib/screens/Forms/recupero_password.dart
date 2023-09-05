import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/shared/validators.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/Form/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';

class RecuperoPassword extends ConsumerStatefulWidget {
  const RecuperoPassword({super.key});

  @override
  ConsumerState<RecuperoPassword> createState() => _RecuperoPasswordState();
}

class _RecuperoPasswordState extends ConsumerState<RecuperoPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController inputEmail = TextEditingController();
  bool isStepOne = true;
  bool validatedOnce = false;
  bool isButtonEnabled = false;
  static const double spacingHeight = 10;

  @override
  void dispose() {
    inputEmail;
    super.dispose();
  }

  void inviaBtnFun() {
    if (_formKey.currentState!.validate()) {
      _saveItem();
    } else {
      if (!validatedOnce) {
        validatedOnce = true;
      }
      _formKey.currentState!.validate();
    }
  }

  void _saveItem() {
    // Send request to server with User in body
    // If response is 200:
    setState(() {
      isStepOne = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Configurazione.colorePrimario,
        content: Text(
          'Some Text',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        //isStepOne
      ),
    );
  }

  bool isEmailValid(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);

    return regex.hasMatch(email);
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
      errorStyle: Theme.of(context).textTheme.bodySmall,

      suffixIcon: LingueFormRegistrazioneHost.mapFieldIcon[fieldName],

      contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      hintText: LingueFormRegistrazioneHost.linguaSuggerimentiForm[languageApp]
          ?[indexField], // SUGGERIMENTI FORM
    );
  }

  Column titleMaker(index, Languages languageApp) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            LinguePasswordDimenticata
                .linguaCampiForm[languageApp]![index], // LABEL FORM
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

  Container stepOne(GlobalKey<FormState> formKey, Languages languageApp,
      bool isStepOne, navigationNotifier) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              titleMaker(0, languageApp),
              Text(LinguePasswordDimenticata.linguaCampiForm[languageApp]![1],
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15)),
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
              CustomElevatedButton(
                title: 'Invia',
                fun: inviaBtnFun,
                paddingVertical: 10,
                paddingHorizontal: 45,
              )
            ]),
      ),
    );
  }

  Container stepTwo(Languages languageApp, navigationNotifier) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleMaker(3, languageApp),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * .05),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Text(
                        maxLines: 5,
                        textAlign: TextAlign.left,
                        LinguePasswordDimenticata
                            .linguaCampiForm[languageApp]![4],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15)),
                  ),
                ]),
            const SizedBox(height: spacingHeight * 2),
            CustomElevatedButton(
              title: 'Torna alla Home',
              fun: () => navigationNotifier.pop(context),
              paddingVertical: 10,
              paddingHorizontal: 45,
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageApp = ref.watch(genericProvider)[0];
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return Scaffold(
        appBar: const CustomAppBar(title: 'Recupero Password', useLogo: true),
        endDrawer: const CustomDrawer(),
        body: isStepOne
            ? stepOne(_formKey, languageApp, isStepOne, navigationNotifier)
            : stepTwo(languageApp, navigationNotifier));
  }
}
