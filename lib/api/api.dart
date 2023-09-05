import 'dart:convert';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/exceptions/exceptions.dart';
import 'package:ask_enzo_app/models/discovery.dart';
import 'package:ask_enzo_app/models/experience.dart';
import 'package:ask_enzo_app/models/popup.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void updateHeaders() {
  headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${kAuthentication.jwt}',
  };
}

Map<String, String> getFileHeaders() {
  return {
    'accept': 'application/json',
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer ${kAuthentication.jwt}',
  };
}

Map<String, String> headers = {
  'accept': 'application/json',
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${kAuthentication.jwt}',
};

// EXPERIENCE
Future<UpdateExperienceModel?> getExperience(ScaffoldMessengerState scaffold,
    {required int id}) async {
  try {
    String url = '${Configurazione.apiGetExperienceURL}?id=$id';

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['result'];
      return toUpdateExperienceModel(responseData);
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return null;
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return null;
}

Future<List<UpdateExperienceModel>?> getExperienceList(
    ScaffoldMessengerState scaffold,
    {required int cursor,
    required int limit}) async {
  try {
    String url =
        '${Configurazione.apiGetExperienceListURL}?cursor=$cursor&limit=$limit';

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<UpdateExperienceModel> result = [];
      dynamic responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['items'];
      for (Map<String, dynamic> item in responseData) {
        result.add(toUpdateExperienceModel(item));
      }
      return result;
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return [];
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return null;
}

// DISCOVERY

Future<UpdateDiscoveryModel?> getDiscovery(ScaffoldMessengerState scaffold,
    {required int id}) async {
  try {
    String url = '${Configurazione.apiGetDiscoveryURL}?id=$id';

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['result'];
      return toUpdateDiscoveryModel(responseData);
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return null;
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
   return null;
}

Future<List<UpdateDiscoveryModel>?> getDiscoveryList(
    ScaffoldMessengerState scaffold,
    {required int cursor,
    required int limit,
    required int category,
    all = false}) async {
  try {
    String url =
        '${Configurazione.apiGetDiscoveryListURL}?cursor=$cursor&limit=$limit&category=$category&all=$all';

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<UpdateDiscoveryModel> result = [];
      dynamic responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['items'];
      for (Map<String, dynamic> item in responseData) {
        result.add(toUpdateDiscoveryModel(item));
      }
      return result;
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return [];
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return null;
}

Future<Map<int, double>?> getDistanceDiscoveriesList(
  ScaffoldMessengerState scaffold, {
  required String userPosition,
}) async {
  try {
    String url =
        '${Configurazione.apiGetDiscoveriesDistancesURL}?my_position=$userPosition';

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)))['result'];
      Map<int, double> result = responseData.map((key, value) =>
          MapEntry(int.parse(key), double.parse(value.toString())));
      return result;
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return {};
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
  return null;
}

// POP UP messages

Future<PopupModel?> getPopupList(ScaffoldMessengerState scaffold,
    {required int cursor, required int limit}) async {
  try {
    String url =
        '${Configurazione.apiGetPopupListURL}?cursor=$cursor&limit=$limit';

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      PopupModel result;

      result = toPopupModel(response);

      return result;
    } else {
      exceptionHandler(response.statusCode, scaffold);
      return null;
    }
  } catch (e) {
    showCustomSnackBar(scaffold, e.toString());
  }
   return null;
}
