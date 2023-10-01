import 'package:flutter/material.dart';

import '../design/colors.dart';
import 'image_view.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.diameter,
    this.path,
    required this.type,
    this.withBorder = false,
    required this.placeholderPath,
  });
  final double diameter;
  final String? path;
  final ImageType type;
  final String placeholderPath;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(diameter / 2)),
        border: withBorder ? Border.all(color: colorGray99) : null,
      ),
      child: ClipOval(
        child: ImageView(
          path ?? '',
          type,
          fit: BoxFit.fill,
          placeHolderImagePath: placeholderPath,
        ),
      ),
    );
  }
}
