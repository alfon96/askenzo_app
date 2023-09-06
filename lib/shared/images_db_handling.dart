import 'package:ask_enzo_app/api/api_images.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// The function clears the image cache for a given URL.
/// 
/// Args:
///   url (String): The `url` parameter is a string that represents the URL of the image that needs to
/// be cleared from the cache.
Future<void> clearImageCache(String url) async {
  await DefaultCacheManager().removeFile(url);
}

/// The function `postImage` takes a `File` object representing an image file and sends it to an API for
/// processing, returning the result as a `Future<String>`.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to show error messages or notifications to the user.
///   imageFile (File): The image file that you want to post. It can be null if no image is selected.
/// 
/// Returns:
///   a `Future<String>`.
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

/// The function `updateImage` updates an image by calling an API and returns the result or 'null' if
/// the update fails.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to show error messages or other notifications to the user.
///   imageFile (File): The image file that needs to be updated. It is of type `File?`, which means it
/// can be null.
///   oldFile (String): The `oldFile` parameter is a required `String` that represents the path or URL
/// of the old image file that needs to be updated.
/// 
/// Returns:
///   a `Future<String>`.
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

/// The function `changeImage` takes in a `ScaffoldMessengerState`, a `File` representing a new image,
/// and an optional `oldImgPath` representing the path of the old image, and returns a `Future<String?>`
/// that represents the result of either posting the new image or updating the old image.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The scaffold parameter is of type ScaffoldMessengerState, which
/// is used to show snackbars or modal bottom sheets within a scaffold.
///   image (File): The new image file that the user wants to change to.
///   oldImgPath (String): The path of the old image file that needs to be replaced. It is an optional
/// parameter and can be null.
/// 
/// Returns:
///   a `Future<String?>`.
Future<String?> changeImage(ScaffoldMessengerState scaffold, File image,
    {String? oldImgPath}) async {
  // Se è la prima volta che pubblica una foto
  if (oldImgPath == null || oldImgPath == "null") {
    return await postImage(scaffold, image);
  }
  // Se sostituisce una foto

  return await updateImage(scaffold, imageFile: image, oldFile: oldImgPath);
}
