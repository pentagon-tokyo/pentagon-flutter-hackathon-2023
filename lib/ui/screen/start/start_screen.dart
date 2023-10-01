import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahha_flutter/sahha_flutter.dart';
import 'package:satorist/ui/component/accept_button.dart';
import 'package:satorist/ui/component/image_view.dart';
import 'package:satorist/ui/screen/tutorial/tutorial_screen.dart';
import 'package:satorist/util/app_router.dart';
import 'package:video_player/video_player.dart';

import '../../../service/tutorial_service.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _controller;
  var _visible = false;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/gif/cut.mp4');
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future(
      () async {
        final hasShown = await ref.read(tutorialServiceProvider).getHasShown();
        if (!hasShown && context.mounted) {
          await showGeneralDialog<void>(
            context: context,
            pageBuilder: (_, __, ___) {
              return const TutorialScreen();
            },
          );
        }
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          _VideoBackground(
            controller: _controller,
            visible: _visible,
          ),
          Center(
            child: ImageView(
              'assets/image/start_logo.png',
              ImageType.asset,
              fit: BoxFit.fill,
              width: 250,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
              child: AcceptButton(
                label: '悟る',
                onPressed: _enableSahhaFlutter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _enableSahhaFlutter() {
    SahhaFlutter.enableSensors().then((value) {
      GoRouter.of(context).push(
        AppRouter.stressResult,
      );
    }).catchError(
      (dynamic error, stackTrace) {
        debugPrint(error.toString());
      },
    );
  }
}

class _VideoBackground extends StatelessWidget {
  const _VideoBackground({
    required this.controller,
    required this.visible,
  });

  final VideoPlayerController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
