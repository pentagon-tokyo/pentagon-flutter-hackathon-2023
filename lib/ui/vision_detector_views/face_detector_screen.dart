// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:satorist/ui/design/my_colors.dart';
import 'package:satorist/ui/screen/meditation_preparation/meditation_preparation_dialog.dart';
import 'package:satorist/util/app_router.dart';
import 'package:satorist/util/gen/assets.gen.dart';

import '../../service/stress_check_service.dart';
import 'detector_view.dart';

class FaceDetectorScreen extends ConsumerStatefulWidget {
  const FaceDetectorScreen({super.key});

  @override
  ConsumerState<FaceDetectorScreen> createState() => _FaceDetectorScreenState();
}

class _FaceDetectorScreenState extends ConsumerState<FaceDetectorScreen> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableLandmarks: true,
      enableClassification: true,
    ),
  );
  final _stopwatch = Stopwatch();
  final backgroundPlayer = AudioPlayer();
  final audioPlayer = AudioPlayer();
  final source = AssetSource('audio/syutyu.wav');
  final backgroundSource = AssetSource('audio/background.mp3');
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  Timer? _timer;
  int _milliseconds = 180000;
  bool _isRunning = false;
  bool _isShowDialog = false;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    _stopwatch.stop();
    _timer?.cancel();
    audioPlayer.dispose();
    backgroundPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final asyncValue = ref.read(stressCheckResultProvider);
      if (!asyncValue.hasValue) {
        return;
      }
      final value = asyncValue.value;
      final time = value?.time;
      if (time == null) {
        return;
      }
      setState(() {
        _milliseconds = value?.timeMillisecond ?? 0;
      });
      showDialog<void>(
        context: context,
        builder: (_) {
          return MeditationPreparationDialog(zazenTime: time);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final minutes =
        ((_milliseconds / (1000 * 60)) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        ((_milliseconds / 1000) % 60).floor().toString().padLeft(2, '0');
    return SafeArea(
      child: Stack(
        children: [
          DetectorView(
            title: 'Face Detector',
            customPaint: _customPaint,
            text: _text,
            onImage: _processImage,
          ),
          _BackButton(
            onTap: () {
              _isBusy = true;
              _isRunning = false;
              if (context.mounted && _isShowDialog) {
                _isShowDialog = false;
                Navigator.of(context).pop();
              }
              _stopwatch.stop();
              audioPlayer.stop();
              backgroundPlayer.stop();
              context.go(AppRouter.start);
            },
          ),
          _TimeLabel(label: '$minutes:$seconds'),
          _BottomButton(
            isRunning: _isRunning,
            onPressed: _start,
          ),
        ],
      ),
    );
  }

  // 計測開始
  void _start() {
    setState(() {
      _isRunning = true;
    });
    backgroundPlayer
      ..play(backgroundSource)
      ..setReleaseMode(ReleaseMode.loop);
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _milliseconds -= 1;
          if (_milliseconds % 1000 == 0) {
            if (context.mounted && _isShowDialog) {
              _isShowDialog = false;
              Navigator.of(context).pop();
            }
          }
          if (_milliseconds <= 0) {
            if (context.mounted && _isShowDialog) {
              _isShowDialog = false;
              Navigator.of(context).pop();
            }
            _stopwatch.stop();
            context.go(AppRouter.zazenSuccess);
          }
        });
      }
    });
  }

  // 開眼判定
  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) {
      return;
    }
    if (_isBusy) {
      return;
    }
    _isBusy = true;
    setState(() {
      _text = '';
    });
    if (!_isRunning) {
      _isBusy = false;
      return;
    }
    final faces = await _faceDetector.processImage(inputImage);
    final firstFace = faces.firstOrNull;
    final leftEyeOpenProbability = firstFace?.leftEyeOpenProbability;
    final rightEyeOpenProbability = firstFace?.rightEyeOpenProbability;
    if (leftEyeOpenProbability != null && rightEyeOpenProbability != null) {
      final eyesAvg = (leftEyeOpenProbability + rightEyeOpenProbability) / 2;
      if (eyesAvg >= 0.9) {
        if (!_isShowDialog) {
          _isShowDialog = true;
          await audioPlayer.play(source);
          if (context.mounted) {
            await showGeneralDialog(
              context: context,
              pageBuilder: (_, __, ___) {
                return Scaffold(
                  backgroundColor: MyColors.black.color.withOpacity(0.5),
                  body: Center(
                    child: Assets.image.zazenFailure.image(),
                  ),
                );
              },
            );
          }
        }
      } else if (eyesAvg < 0.1) {
        debugPrint('閉眼');
      } else {
        debugPrint('半目');
      }
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 53 + 12,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4.22),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Assets.image.left.svg(width: 16, height: 15.56),
          ),
        ),
      ),
    );
  }
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 12,
      child: FittedBox(
        child: Text(
          label,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: MyColors.white.color),
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({
    required this.isRunning,
    required this.onPressed,
  });
  final bool isRunning;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      right: 16,
      child: isRunning
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Text(
                '瞑想中',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: MyColors.white.color),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32), //角の丸み
                ),
              ),
              child: Text(
                'スタート',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: MyColors.white.color),
              ),
            ),
    );
  }
}
