import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:flutter/material.dart';

/// The `CustomDropDownButton` class is a stateful widget that represents a custom dropdown button with
/// customizable values, initial value, and a function to update the selected value.
class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    super.key,
    required this.mapValues,
    required this.inputDecoration,
    required this.initialValue,
    required this.updateValue,
  });
  final Map<Widget, int> mapValues;
  final String inputDecoration;
  final int initialValue;
  final Function updateValue;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

/// The `_CustomDropDownButtonState` class is a stateful widget that displays a dropdown button form
/// field with customizable options in Dart.
class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  int? dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: widget.inputDecoration,
        labelStyle: const TextStyle(
            fontSize: 18,
            color: Configurazione.colorePrimario,
/// The `_CustomFormDatePickerState` class is a stateful widget that displays a text form field with a
/// date picker functionality in Dart.
            fontFamily: Configurazione.fontFamilyBody,
            fontWeight: FontWeight.w600),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 25.0,
        ),
      ),
      value: widget.initialValue,
      items: widget.mapValues.entries.map((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * .7, child: entry.key),
        );
      }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.updateValue(dropdownValue);
        });
      },
      onSaved: (int? newValue) {
        dropdownValue = newValue!;
      },
    );
  }
}
