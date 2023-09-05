import 'package:ask_enzo_app/api/api_images.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<void> clearImageCache(String url) async {
  await DefaultCacheManager().removeFile(url);
}

Future<String> postImage(
    ScaffoldMessengerState scaffold, File? imageFile) async {
  if (imageFile != null) {
    try {
      String? result = await apiPostImage(scaffold, imgPath: imageFile.path);
      if (result != null) {
        return result;
      } else {
        return 'null';
      }
    } catch (e) {
      return '';
    }
  } else {
    return '';
  }
}

Future<String> updateImage(ScaffoldMessengerState scaffold,
    {required File? imageFile, required String oldFile}) async {
  if (imageFile != null) {
    try {
      String? result = await apiUpdateImage(scaffold,
          imgFile: imageFile, oldImgPath: oldFile);
      if (result != null) {
        return result;
      } else {
        return 'null';
      }
    } catch (e) {
      return '';
    }
  } else {
    return '';
  }
}

Future<String?> changeImage(ScaffoldMessengerState scaffold, File image,
    {String? oldImgPath}) async {
  // Se è la prima volta che pubblica una foto
  if (oldImgPath == null || oldImgPath == "null") {
    return await postImage(scaffold, image);
  }
  // Se sostituisce una foto

  return await updateImage(scaffold, imageFile: image, oldFile: oldImgPath);
}
