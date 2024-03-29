import 'dart:convert';
import 'package:ask_enzo_app/api/api.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/exceptions/exceptions.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

/// The `apiPostImage` function sends a POST request to upload an image file to a specified URL and
/// returns the result.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display error messages or notifications on the screen. It is
/// typically associated with a `ScaffoldMessenger` widget.
///   imgPath (String): The `imgPath` parameter is a required string that represents the file path of
/// the image that needs to be uploaded.
/// 
/// Returns:
///   a `Future<String?>`.
Future<String?> apiPostImage(ScaffoldMessengerState scaffoldMessenger,
    {required String imgPath}) async {
  try {
    final file = File(imgPath);
    String url = Configurazione.apiPostImage;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(getFileHeaders());
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBytes = await http.ByteStream(response.stream).toBytes();
      return jsonDecode((utf8.decode(responseBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return null;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return null;
}

/// The function `apiUpdateImage` is a Dart function that sends a PATCH request to update an image file
/// on a server and returns the result.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): A reference to the ScaffoldMessengerState, which is
/// used to show snackbar messages.
///   imgFile (File): The `imgFile` parameter is a required `File` object that represents the image file
/// to be updated.
///   oldImgPath (String): The `oldImgPath` parameter is a required String that represents the path of
/// the old image file.
/// 
/// Returns:
///   a `Future<String?>`.
Future<String?> apiUpdateImage(ScaffoldMessengerState scaffoldMessenger,
    {required File imgFile, required String oldImgPath}) async {
  try {
    String url =
        '${Configurazione.apiUpdateImage}?old_file_name=${getFileNameWithExtension(oldImgPath)}';

    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers.addAll(getFileHeaders());
    request.files.add(await http.MultipartFile.fromPath('file', imgFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBytes = await http.ByteStream(response.stream).toBytes();
      return jsonDecode((utf8.decode(responseBytes)))['result'];
    } else {
      exceptionHandler(response.statusCode, scaffoldMessenger);
      return null;
    }
  } catch (e) {
    showCustomSnackBar(scaffoldMessenger, e.toString());
  }
  return null;
}

/// The function `apiDeleteImage` is a Dart function that sends a DELETE request to a specified API
/// endpoint to delete an image, and returns a boolean indicating whether the deletion was successful or
/// not.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The `scaffoldMessenger` parameter is of type
/// `ScaffoldMessengerState` and is used to display snackbar messages or other notifications to the
/// user. It is typically obtained from the `ScaffoldMessenger.of(context)` method.
///   imgPath (String): The `imgPath` parameter is a required string that represents the path of the
/// image file that needs to be deleted.
/// 
/// Returns:
///   a `Future<bool>`.
Future<bool> apiDeleteImage(ScaffoldMessengerState scaffoldMessenger,
    {required String imgPath}) async {
  try {
    String url =
        '${Configurazione.apiDeleteImage}?image_name=${getFileNameWithExtension(imgPath)}';
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
