import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:flutter/material.dart';

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
