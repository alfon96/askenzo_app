import 'dart:convert';
import 'package:ask_enzo_app/api/api.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/exceptions/exceptions.dart';
import 'package:ask_enzo_app/models/host.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

// HOST

/// The `apiHostLogin` function is a Dart function that sends a login request to an API host and returns
/// a boolean value indicating whether the login was successful or not.
///
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbar messages in the UI. It is required to show
/// error messages or notifications to the user.
///   email (String): The email parameter is a required string that represents the user's email address.
/// It is used as a parameter in the API request to authenticate the user.
///   password (String): The password parameter is a required string that represents the user's password
/// for authentication.
///
/// Returns:
///   a `Future<bool>`.
Future<bool> apiHostLogin(
  ScaffoldMessengerState scaffoldMessenger, {
  required String email,
  required String password,
}) async {
  try {
    String url =
        '${Configurazione.apiHostLogin}?email=$email&password=$password';
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode((utf8.decode(response.bodyBytes)));
      String? token = responseData['access_token'];
      if (token != null) {
        kAuthentication.jwt = token;
        return true;
      }
      return false;
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return false;
}

/// The function `apiHostGetMyInfo` makes an HTTP GET request to retrieve the host's information and
/// returns a `Host` object if successful, otherwise it handles any exceptions and returns null.
///
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState`. It is used to display error messages or notifications to the user.
///
/// Returns:
///   a `Future` object that resolves to a `Host` object or `null`.
Future<Host?> apiHostGetMyInfo(ScaffoldMessengerState scaffoldMessenger) async {
  try {
    String url = Configurazione.apiHostGetMyInfo;
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['result'];
      return toHost(responseData);
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return null;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return null;
}

/// The function `apiHostUpdatePassword` sends a PATCH request to update the password on the API host
/// and returns a boolean indicating whether the password was successfully updated.
///
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbar messages in the UI. It is required for
/// showing error messages or notifications to the user.
///   oldPassword (String): The old password that the user wants to update.
///   newPassword (String): The new password that the user wants to update to.
///
/// Returns:
///   a `Future<bool>`.
Future<bool> apiHostUpdatePassword(
  ScaffoldMessengerState scaffoldMessenger, {
  required String oldPassword,
  required String newPassword,
}) async {
  try {
    String url =
        '${Configurazione.apiHostUpdatePassword}?old_password=$oldPassword&new_password=$newPassword';
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode((utf8.decode(response.bodyBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return false;
}

/// The function `apiHostUpdateInfo` is an asynchronous function that sends a PATCH request to update
/// user information and returns a boolean indicating whether the update was successful or not.
///
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbars or other notifications to the user. It is
/// typically obtained from the `ScaffoldMessenger.of(context)` method.
///   newName (String): The new name to update in the API host's information.
///   newSurname (String): The new surname to update in the API.
///   newEmail (String): The new email address that will be updated in the API.
///   newImgProfile (String): The parameter "newImgProfile" is a string that represents the new profile
/// image URL that will be updated in the API.
///   newTelephone (String): The new telephone number that will be updated in the API.
///
/// Returns:
///   a `Future<bool>`.
Future<bool> apiHostUpdateInfo(ScaffoldMessengerState scaffoldMessenger,
    {String newName = '',
    String newSurname = '',
    String newEmail = '',
    String newImgProfile = '',
    String newTelephone = ''}) async {
  try {
    String url =
        '${Configurazione.apiHostUpdateInfo}?new_name=$newName&new_surname=$newSurname&new_email=$newEmail&new_img_profile=$newImgProfile&new_state_id=1&new_telephone=$newTelephone';
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode((utf8.decode(response.bodyBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return false;
}

/// The function `apiHostRegister` sends a POST request to a specified URL with the provided host data
/// and returns a boolean indicating the success of the request.
///
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbars or other notifications to the user. It is
/// typically obtained by calling `ScaffoldMessenger.of(context)` within a widget's build method.
///   host (Host): The `host` parameter is an object of type `Host`. It is required and contains the
/// data that needs to be sent in the request body. The `toJson()` method is called on the `host` object
/// to convert it into a JSON string before sending it in the request body.
///
/// Returns:
///   a `Future<bool>`.

Future<bool> apiHostRegister(ScaffoldMessengerState scaffoldMessenger,
    {required Host host}) async {
  try {
    String url = Configurazione.apiHostRegister;
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: host.toJson(),
    );

    if (response.statusCode == 200) {
      return jsonDecode((utf8.decode(response.bodyBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return false;
}

/// The function `apiHostDeleteMe` sends a DELETE request to a specified API endpoint with a password
/// parameter, handles the response, and returns a boolean indicating success or failure.
///
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbar messages or other notifications to the
/// user. It is typically obtained from the `ScaffoldMessenger.of(context)` method.
///   password (String): The password parameter is a required string that is used to authenticate the
/// user before deleting their account.
///
/// Returns:
///   a `Future<bool>`.
Future<bool> apiHostDeleteMe(ScaffoldMessengerState scaffoldMessenger,
    {required String password}) async {
  try {
    String url = '${Configurazione.apiHostDeleteMe}?password=$password';
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode((utf8.decode(response.bodyBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return false;
}
