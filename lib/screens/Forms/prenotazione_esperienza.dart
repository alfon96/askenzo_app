import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/shared/validators.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/extensions/extensions.dart';
import 'package:ask_enzo_app/widgets/Form/custom_date_picker.dart';
import 'package:ask_enzo_app/widgets/Form/custom_dropdown_button.dart';
import 'package:ask_enzo_app/widgets/Form/custom_text_form_field.dart';
import 'package:ask_enzo_app/widgets/ListTile/custom_image_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';

final formatter = DateFormat.yMd();

Map<Widget, int> itemMap = {
  const CustomImageListTile(
      imgPath: 'assets/flags/it.png', width: 50, text: 'Italiano'): 1,
  const CustomImageListTile(
      imgPath: 'assets/flags/gb-nir.png', width: 50, text: 'English'): 2,
  const CustomImageListTile(
      imgPath: 'assets/flags/fr.png', width: 50, text: 'Français'): 3,
  const CustomImageListTile(
      imgPath: 'assets/flags/de.png', width: 50, text: 'Deutsch'): 4,
};

const spaceBetweenFields = 20.0;

/// The class FormPrenotazioniEsperienze is a stateful widget that extends ConsumerStatefulWidget.
class FormPrenotazioniEsperienze extends ConsumerStatefulWidget {
  const FormPrenotazioniEsperienze({super.key});

  @override
  ConsumerState<FormPrenotazioniEsperienze> createState() =>
      _FormPrenotazioniEsperienzeState();
}

/// The `_FormPrenotazioniEsperienzeState` class is a stateful widget that represents a form for making
/// reservations for experiences.
class _FormPrenotazioniEsperienzeState
    extends ConsumerState<FormPrenotazioniEsperienze> {
  final _formKey = GlobalKey<FormState>();
  DateTime today = DateTime.now();

  DateTime _selectedDate = DateTime.now();
  final TextEditingController _inputPhoneNuber = TextEditingController();
  final TextEditingController _inputPeopleNumber = TextEditingController();
  int chosenLanguage = 1;
  bool isButtonEnabled = false;
  bool validatedOnce = false;

  @override
  void dispose() {
    _inputPhoneNuber.dispose();
    _inputPeopleNumber.dispose();
    super.dispose();
  }

  final dateController = TextEditingController();
  void checkButtonEnabling() {}

  String getLanguageName(Languages value) {
    if (value.name == 'french') {
      return 'Français';
    } else {
      return value.name.capitalize();
    }
  }

  void _saveItem(Languages languageApp) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          LingueFormPrenotazione.linguaSnackBar[languageApp]!,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
        showCloseIcon: true,
      ),
    );
  }

  InputDecoration formStyling(int indexField, Languages languageApp) {
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
      suffixIcon: indexField == 1 ? const Icon(Icons.people) : null,
      contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),

      hintText: LingueFormPrenotazione.linguaSuggerimentiForm[languageApp]
          ?[indexField], // SUGGERIMENTI FORM
    );
  }

  pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    var picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = formatter.format(_selectedDate);
        checkButtonEnabling();
      });
    }
  }

  Column titleMaker(index, Languages languageApp) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            LingueFormPrenotazione.linguaCampiForm[languageApp]
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
    final languageApp = ref.watch(genericProvider)[0];

    return Scaffold(
      appBar: CustomAppBar(title: LingueFormPrenotazione.prenota[languageApp]!),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: spacingHeight),
              Form(
                key: _formKey,
                child: Column(children: [
                  CustomFormDatePicker(
                      title: 'Seleziona una data',
                      hintText: 'Clicca qui per selezionare una data.',
                      fieldValue: dateController,
                      icon: const Icon(Icons.calendar_month),
                      validatorFun: validateDate),
                  const SizedBox(height: spacingHeight),
                  CustomTextFormField(
                    title: 'N° di Persone',
                    fieldValue: _inputPeopleNumber,
                    validatorFun: validateInteger,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: spacingHeight),
                  CustomTextFormField(
                    obscureText: false,
                    title: 'Telefono',
                    hintText: 'es. 371184598',
                    fieldValue: _inputPhoneNuber,
                    keyboardType: TextInputType.number,
                    validatorFun: validatePhone,
                    icon: const Icon(Icons.smartphone),
                    iconBtnFun: () {},
                  ),
                  const SizedBox(height: spacingHeight),
                  CustomDropDownButton(
                    mapValues: itemMap,
                    inputDecoration: 'Lingua Di Preferenza:',
                    initialValue: chosenLanguage,
                    updateValue: (value) => chosenLanguage = value,
                  ),
                  const SizedBox(height: spacingHeight * 2),
                  CustomElevatedButton(
                    fun: isButtonEnabled
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              _saveItem(languageApp);
                            }
                          }
                        : () {
                            if (!validatedOnce) {
                              validatedOnce = true;
                            }
                            _formKey.currentState!.validate();
                          },
                    title: 'Procedi al Pagamento',
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
