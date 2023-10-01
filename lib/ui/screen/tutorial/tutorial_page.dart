import 'package:flutter/material.dart';
import 'package:satorist/ui/component/image_view.dart';

import '../../design/spaces.dart';
import '../../design/text_styles.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({
    super.key,
    required this.title,
    required this.message,
    required this.image,
  });
  final String title;
  final String message;
  final ImageView image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textStyle(const [fontSize32, bold, white]),
                ),
              ),
              spaceH12,
              Text(
                message,
                style: textStyle(const [fontSize15, bold, white]),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(child: image),
        ),
      ],
    );
  }
}
