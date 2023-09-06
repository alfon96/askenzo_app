import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';

/// The function `exceptionHandler` handles different HTTP status codes and displays corresponding error
/// messages using a `ScaffoldMessenger`.
/// 
/// Args:
///   statusCode (int): The `statusCode` parameter is an integer representing the HTTP status code
/// returned by a server response. It is used to determine the appropriate error message to display.
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState`, which is used to show a snackbar message on the screen. It is typically
/// obtained from the `ScaffoldMessenger.of(context)` method, where `context` is the current build
/// context.
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
