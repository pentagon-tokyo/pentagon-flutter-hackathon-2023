import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageType { asset, file, url }

// ignore: must_be_immutable
class ImageView extends StatefulWidget {
  ImageView(
    this.path,
    this.type, {
    this.height,
    this.width,
    this.placeHolderImagePath,
    required this.fit,
    super.key,
  });
  String path;
  ImageType type;
  double? height;
  double? width;
  String? placeHolderImagePath;
  BoxFit fit;

  @override
  State<StatefulWidget> createState() {
    return ImageState();
  }
}

class ImageState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return showImage(
      widget.path,
      widget.type,
      widget.height,
      widget.width,
      widget.placeHolderImagePath,
      widget.fit,
    );
  }

  Widget showImage(
    String path,
    ImageType type,
    double? height,
    double? width,
    String? placeHolderImagePath,
    BoxFit fit,
  ) {
    switch (type) {
      case ImageType.asset:
        try {
          return Image.asset(
            path,
            height: height,
            width: width,
            fit: fit,
          );
        } on Exception catch (e) {
          log(e.toString());
          return placeHolder(height, width, placeHolderImagePath, fit);
        }
      case ImageType.file:
        try {
          final f = File(path);
          if (f.existsSync()) {
            return Image.file(
              f,
              height: height,
              width: width,
              fit: fit,
            );
          } else {
            return placeHolder(height, width, placeHolderImagePath, fit);
          }
        } on Exception catch (e) {
          log(e.toString());
          return placeHolder(height, width, placeHolderImagePath, fit);
        }
      case ImageType.url:
        try {
          return SizedBox(
            width: width,
            child: CachedNetworkImage(
              imageUrl: path,
              placeholder: (context, url) =>
                  placeHolder(height, width, placeHolderImagePath, fit),
              errorWidget: (context, url, dynamic error) =>
                  placeHolder(height, width, placeHolderImagePath, fit),
              height: height,
              fit: fit,
            ),
          );
        } on Exception catch (e) {
          log(e.toString());
          return placeHolder(height, width, placeHolderImagePath, fit);
        }
    }
  }

  Widget placeHolder(
    double? height,
    double? width,
    String? placeHolderImagePath,
    BoxFit fit,
  ) {
    if (placeHolderImagePath == null || placeHolderImagePath.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey,
      );
    }
    return Image.asset(
      placeHolderImagePath,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
