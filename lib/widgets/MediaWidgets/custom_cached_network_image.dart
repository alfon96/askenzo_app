import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imgPath,
    this.heightCircularProgress = 20.0,
    this.widthCircularProgress = 20.0,
  });
  final String imgPath;
  final double widthCircularProgress;
  final double heightCircularProgress;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      useOldImageOnUrlChange: false,
      imageUrl: imgPath,
      placeholder: (context, url) => Center(
          child: SizedBox(
              height: heightCircularProgress,
              width: widthCircularProgress,
              child: const Center(child: CircularProgressIndicator()))),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
      fit: BoxFit.cover,
    );
  }
}
