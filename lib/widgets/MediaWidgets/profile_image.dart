import 'package:ask_enzo_app/widgets/MediaWidgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

/// The `ProfileImage` class is a widget that displays a profile image either from a URL or a local
/// file, and handles the case when the image is not available.

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.name,
    required this.surname,
    required this.imgPath,
    this.size = 130,
  });
  final String name;
  final String surname;
  final String imgPath;
  final double size;

  Future<bool> isImageURLValid() async {
    try {
      final response = await http.head(Uri.parse(imgPath));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget loadImage(String imagePath) {
      // Define the patterns for a URL (HTTP or HTTPS)
      RegExp regExp = RegExp(
        r"(http|https)://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?",
        caseSensitive: false,
        multiLine: false,
      );

      // If the imagePath is an URL
      if (regExp.hasMatch(imagePath)) {
        return SizedBox(
          height: size,
          width: size,
          child: ClipOval(
            child: CustomCachedNetworkImage(
              imgPath: imagePath,
            ),
          ),
        );
      }
      // If the imagePath is a file
      else {
        File imageFile = File(imagePath);

        // Check if file exists before displaying
        if (imageFile.existsSync()) {
          return SizedBox(
            height: size,
            width: size,
            child: ClipOval(
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return ProfilePicture(
            name: '$name $surname',
            radius: size / 2,
            fontsize: size / 2.2,
            img: null,
          );
        }
      }
    }

    return FutureBuilder(
        future: isImageURLValid(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: size,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return loadImage(imgPath);
          }
        });
  }
}
