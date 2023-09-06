import 'dart:convert';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/exceptions/exceptions.dart';
import 'package:ask_enzo_app/models/discovery.dart';
import 'package:ask_enzo_app/models/experience.dart';
import 'package:ask_enzo_app/models/popup.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// The `apiTouristLogin` function is a Dart function that sends a POST request to a tourist login API
/// endpoint with an email and password, and returns a boolean indicating whether the login was
/// successful or not.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbar messages in the UI.
///   email (String): The email parameter is a string that represents the user's email address. It is
/// used as a parameter in the API request to authenticate the user.
///   password (String): The password parameter is a string that represents the user's password for
/// authentication.
/// 
/// Returns:
///   a `Future<bool>`.
/// The function updates the headers with the necessary information for making authenticated API
/// requests.
void updateHeaders() {
  headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${kAuthentication.jwt}',
  };
}

/// The function returns a map of headers for a file request, including accept, content-type, and
/// authorization.
/// 
/// Returns:
///   The method `getFileHeaders()` returns a `Map` object with string keys and string values.
Map<String, String> getFileHeaders() {
  return {
    'accept': 'application/json',
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer ${kAuthentication.jwt}',
  };
}

/// The `Map<String, String> headers` variable is a map that contains the headers to be included in the
/// HTTP requests made to the API. It includes the following headers:
Map<String, String> headers = {
  'accept': 'application/json',
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${kAuthentication.jwt}',
};

// EXPERIENCE
/// The function `getExperience` retrieves an experience from an API using an HTTP GET request and
/// returns it as an `UpdateExperienceModel` object.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to show error messages or notifications on the screen.
///   id (int): The `id` parameter is an integer that represents the unique identifier of the experience
/// you want to retrieve.
/// 
/// Returns:
///   a `Future` object that resolves to an `UpdateExperienceModel` or `null`.
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

/// The function `getExperienceList` retrieves a list of experiences from an API endpoint and returns it
/// as a list of `UpdateExperienceModel` objects.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to display error messages or notifications on the screen.
///   cursor (int): The cursor parameter is used to specify the starting point of the list of
/// experiences to retrieve. It helps in pagination by indicating the position from where the next set
/// of experiences should be fetched.
///   limit (int): The `limit` parameter specifies the maximum number of items to be returned in the
/// response. It determines the number of experiences to be fetched from the API.
/// 
/// Returns:
///   a `Future<List<UpdateExperienceModel>?>`.
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

/// The function `getDiscovery` retrieves discovery data from an API endpoint and returns it as an
/// `UpdateDiscoveryModel` object, or null if there is an error.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to show error messages or notifications on the screen.
///   id (int): The `id` parameter is an integer value that represents the unique identifier of the
/// discovery you want to retrieve.
/// 
/// Returns:
///   a `Future` object that resolves to an `UpdateDiscoveryModel` or `null`.
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

/// The function `getDiscoveryList` retrieves a list of discovery items from an API based on the
/// provided parameters.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to display error messages or notifications to the user.
///   cursor (int): The cursor parameter is used to specify the starting point of the data to be
/// fetched. It helps in pagination by indicating the position from where the next set of data should be
/// retrieved.
///   limit (int): The `limit` parameter specifies the maximum number of items to be returned in the
/// list.
///   category (int): The `category` parameter is an integer that represents the category of the
/// discovery list. It is required for fetching the discovery list from the API.
///   all: The "all" parameter is a boolean value that determines whether to fetch all discovery items
/// or only a specific category. If "all" is set to true, it will fetch all discovery items regardless
/// of the category. If "all" is set to false, it will fetch only the discovery items of. Defaults to
/// false
/// 
/// Returns:
///   a `Future<List<UpdateDiscoveryModel>?>`.
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

/// The function `getDistanceDiscoveriesList` retrieves a map of distances for discoveries based on the
/// user's position.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to display error messages or notifications to the user.
///   userPosition (String): The user's current position, represented as a string.
/// 
/// Returns:
///   a Future object that resolves to a Map<int, double> or null.
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
/// The function `getPopupList` retrieves a list of popups from an API endpoint and returns a
/// `PopupModel` object if successful, otherwise it handles any exceptions and returns null.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to show error messages or custom snack bars.
///   cursor (int): The `cursor` parameter is used to specify the starting point of the data to be
/// fetched. It helps in pagination by indicating the position from where the next set of data should be
/// retrieved.
///   limit (int): The `limit` parameter specifies the maximum number of popups to retrieve from the
/// API.
/// 
/// Returns:
///   a `Future<PopupModel?>`.

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
