import 'dart:convert';
import 'package:ask_enzo_app/api/api.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/exceptions/exceptions.dart';
import 'package:ask_enzo_app/models/host.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

// HOST

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
