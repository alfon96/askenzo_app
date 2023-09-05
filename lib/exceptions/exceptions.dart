import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';

void exceptionHandler(
    int statusCode, ScaffoldMessengerState scaffoldMessenger) {
  Map<int, String> messageMap = {
    400: 'L\'email/numero di telefono sono già stati usati',
    401: 'Autenticazione fallita',
    403: 'La password inserita è incorretta',
    404: 'Server non disponibile',
    422: 'Errore nella richiesta al server',
    500: 'Impossibile contattare il server',
  };

  if (messageMap.containsKey(statusCode)) {
    showCustomSnackBar(scaffoldMessenger, messageMap[statusCode]!);
  }
}
