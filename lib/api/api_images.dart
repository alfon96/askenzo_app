import 'dart:convert';
import 'package:ask_enzo_app/api/api.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/exceptions/exceptions.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

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
