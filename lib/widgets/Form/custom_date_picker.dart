import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class CustomFormDatePicker extends StatefulWidget {
  const CustomFormDatePicker({
    super.key,
    required this.title,
    required this.fieldValue,
    required this.validatorFun,
    this.icon,
    this.hintText,
    this.contentPaddingL = 0.0,
    this.contentPaddingT = 0.0,
    this.contentPaddingR = 0.0,
    this.contentPaddingB = 0.0,
    this.initialValue = '',
  });
  final String title;
  final TextEditingController fieldValue;
  final String? hintText;
  final Function validatorFun;
  final Icon? icon;
  final double contentPaddingL;
  final double contentPaddingR;
  final double contentPaddingT;
  final double contentPaddingB;
  final String initialValue;
  @override
  State<CustomFormDatePicker> createState() => _CustomFormDatePickerState();
}

class _CustomFormDatePickerState extends State<CustomFormDatePicker> {
  DateTime selectedDate = DateTime.now();
  Color iconColor = Colors.black54;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void pickDate() async {
      final now = DateTime.now();
      final firstDate = DateTime(now.year, now.month, now.day + 1);
      final lastDate = DateTime(now.year + 1, now.month, now.day);

      var picked = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          widget.fieldValue.text = formatter.format(selectedDate);
        });
      }
    }

    return TextFormField(
      onTap: () async => pickDate(),
      readOnly: true,
      initialValue: null,
      autofocus: false,
      validator: (value) => widget.validatorFun(selectedDate),
      controller: widget.fieldValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          widget.contentPaddingL,
          widget.contentPaddingT,
          widget.contentPaddingR,
          widget.contentPaddingB,
        ),
        errorMaxLines: 2,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.title,
        //border: InputBorder.none,
        hintText: widget.hintText,
        labelStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Configurazione.colorePrimario,
        ),
        suffixIcon: widget.icon != null
            ? IconButton(
                color: iconColor,
                icon: widget.icon!,
                onPressed: () {},
              )
            : null,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
