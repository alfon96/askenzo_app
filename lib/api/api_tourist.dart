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
