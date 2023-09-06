import 'dart:convert';
import 'package:ask_enzo_app/api/api.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/exceptions/exceptions.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// TOURIST
Future<bool> apiTouristLogin(
  ScaffoldMessengerState scaffoldMessenger, {
  String email = '',
  String password = '',
}) async {
  try {
    String url =
        '${Configurazione.apiTouristLogin}?email=$email&password=$password';
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
// email@email.com

/// The function `apiTouristGetMyInfo` makes an HTTP GET request to retrieve the logged-in tourist's
/// information and returns a `Tourist` object if successful, otherwise it handles any exceptions and
/// returns null.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState`. It is used to display snackbar messages in the UI.
/// 
/// Returns:
///   a `Future` object that resolves to a `Tourist` object or `null`.
Future<Tourist?> apiTouristGetMyInfo(
    ScaffoldMessengerState scaffoldMessenger) async {
  try {
    String url = Configurazione.apiTouristGetMyInfo;
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['result'];
      return toTourist(responseData);
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return null;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return null;
}

/// The function `apiTouristUpdatePassword` is a Dart function that sends a PATCH request to update a
/// tourist's password and returns a boolean indicating whether the update was successful or not.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbar messages to the user. It is typically
/// obtained from the `ScaffoldMessenger.of(context)` method.
///   oldPassword (String): The old password of the user that needs to be updated.
///   newPassword (String): The new password that the user wants to set for their account.
/// 
/// Returns:
///   a `Future<bool>`.
Future<bool> apiTouristUpdatePassword(
  ScaffoldMessengerState scaffoldMessenger, {
  String oldPassword = '',
  String newPassword = '',
}) async {
  try {
    String url =
        '${Configurazione.apiTouristUpdatePassword}?old_password=$oldPassword&new_password=$newPassword';
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

/// The function `apiTouristUpdateInfo` sends a PATCH request to update tourist information and returns
/// a boolean indicating the success of the operation.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbar messages or other notifications to the
/// user. It is typically obtained from the `ScaffoldMessenger.of(context)` method.
///   newName (String): The new name of the tourist.
///   newSurname (String): The new surname of the tourist.
///   newEmail (String): The new email address for the tourist's account.
///   newImgProfile (String): The parameter "newImgProfile" is a string that represents the new profile
/// image URL for the tourist.
///   newTelephone (String): The new telephone number that the tourist wants to update in their profile.
/// 
/// Returns:
///   a `Future<bool>`.
Future<bool> apiTouristUpdateInfo(ScaffoldMessengerState scaffoldMessenger,
    {String newName = '',
    String newSurname = '',
    String newEmail = '',
    String newImgProfile = '',
    String newTelephone = ''}) async {
  try {
    String url =
        '${Configurazione.apiTouristUpdateInfo}?new_name=$newName&new_surname=$newSurname&new_email=$newEmail&new_img_profile=$newImgProfile&new_state_id=1&new_telephone=$newTelephone';
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

/// The function `apiTouristRegister` sends a POST request to a specified URL with a tourist
/// registration object as the body, and returns a boolean indicating whether the registration was
/// successful or not.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to display error messages or notifications to the user.
///   tourist (TouristRegister): The `tourist` parameter is an object of type `TouristRegister` which
/// contains the information of the tourist being registered.
/// 
/// Returns:
///   a `Future<bool>`.
Future<bool> apiTouristRegister(ScaffoldMessengerState scaffold,
    {required TouristRegister tourist}) async {
  try {
    var body = tourist.toJson();
    String url = Configurazione.apiTouristRegister;
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode((utf8.decode(response.bodyBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return false;
}

/// The function `apiTouristDeleteMe` sends a DELETE request to a specified API endpoint with a password
/// parameter, and returns a boolean indicating whether the request was successful.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to display error messages or notifications to the user.
///   password (String): The password parameter is a required string that represents the user's
/// password.
/// 
/// Returns:
///   a `Future<bool>`.
Future<bool> apiTouristDeleteMe(ScaffoldMessengerState scaffold,
    {required String password}) async {
  try {
    String url = '${Configurazione.apiTouristDeleteMe}?password=$password';
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode((utf8.decode(response.bodyBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return false;
}

/// The function `apiTouristGetMyLikes` makes an API call to retrieve a list of likes and handles any
/// exceptions or errors that occur.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to display error messages or notifications to the user.
/// 
/// Returns:
///   a `Future` object that resolves to a `List<int>`.
Future<List<int>> apiTouristGetMyLikes(
  ScaffoldMessengerState scaffold,
) async {
  try {
    String url = Configurazione.apiTouristGetMyLikes;
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['result'];

      return convertList(responseData);
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return [];
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return [];
}

/// The function `apiTouristToggleLike` sends a POST request to a specified URL with the experience ID,
/// handles the response, and returns a boolean indicating whether the request was successful.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to show error messages or notifications to the user.
///   experienceId (int): The ID of the experience that the user wants to toggle the like for.
/// 
/// Returns:
///   a `Future<bool>`.
Future<bool> apiTouristToggleLike(ScaffoldMessengerState scaffold,
    {required int experienceId}) async {
  try {
    String url =
        '${Configurazione.apiTouristToggleLike}?experience_id=$experienceId';
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode((utf8.decode(response.bodyBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return false;
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return false;
}

/// The function `convertList` takes a list of dynamic elements and returns a new list containing only
/// the integer elements, converting any string elements to integers if possible.
/// 
/// Args:
///   inputList (List<dynamic>): The inputList parameter is a List of dynamic type, which means it can
/// contain elements of any type.
/// 
/// Returns:
///   a List<int> containing the converted elements from the inputList.
List<int> convertList(List<dynamic> inputList) {
  List<int> resultList = [];

  for (var element in inputList) {
    if (element is int) {
      resultList.add(element);
    } else if (element is String) {
      int parsedInt = int.parse(element);
      resultList.add(parsedInt);
    }
  }

  return resultList;
}
