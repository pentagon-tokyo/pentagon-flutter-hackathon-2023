import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/text_styles.dart';

/// ボタン
class AcceptButton extends StatelessWidget {
  const AcceptButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = colorPrimaryDark,
    this.borderColor = colorWhite,
    this.borderWidth = 1.0,
    this.textStyles = const [white, fontSize14],
    this.shape,
    this.radius = 12.0,
    this.height = 44.0,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final List<TextStyle> textStyles;
  final ShapeBorder? shape;
  final double radius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: double.infinity,
      color: color,
      // 非活性時の透過率を50%にする
      disabledColor: Color(color.value - 0xAF000000),
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor, width: borderWidth),
          ),
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle(textStyles),
      ),
    );
  }
}
