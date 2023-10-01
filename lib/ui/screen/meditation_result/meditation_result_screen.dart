import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satorist/ui/component/accept_button.dart';
import 'package:satorist/ui/component/circle_image.dart';
import 'package:satorist/ui/component/image_view.dart';
import 'package:satorist/ui/design/my_colors.dart';
import 'package:satorist/ui/design/spaces.dart';

import '../../../util/app_router.dart';

class MeditationResultScreen extends StatelessWidget {
  const MeditationResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AudioPlayer().play(AssetSource('audio/satottane.wav'));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          spaceH64,
          Text(
            'あなたは\n悟りの境地です',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
          const Center(
            child: CircleImage(
              path: 'assets/image/satori.png',
              type: ImageType.asset,
              diameter: 300,
              placeholderPath: 'assets/image/satori.png',
            ),
          ),
          spaceH64,
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AcceptButton(
                label: '悟りました',
                onPressed: () {
                  GoRouter.of(context).pushReplacement(
                    AppRouter.start,
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                child: Text(
                  '悟り足りない',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: MyColors.white.color,
                        decoration: TextDecoration.underline,
                      ),
                ),
                onPressed: () {
                  context
                    ..pushReplacement(
                      AppRouter.start,
                    )
                    ..push(AppRouter.faceDetector);
                },
              ),
            ),
          ),
          spaceH24,
        ],
      ),
    );
  }
}
