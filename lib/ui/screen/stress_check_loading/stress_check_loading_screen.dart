import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

import '../../../util/gen/assets.gen.dart';
import '../../design/spaces.dart';

class StressCheckLoadingScreen extends StatefulWidget {
  const StressCheckLoadingScreen({super.key});

  @override
  State<StressCheckLoadingScreen> createState() => _StressCheckLoadingState();
}

class _StressCheckLoadingState extends State<StressCheckLoadingScreen>
    with SingleTickerProviderStateMixin {
  late final FlutterGifController _controller;

  @override
  void initState() {
    _controller = FlutterGifController(vsync: this);
    _controller.repeat(
      min: 0,
      max: 30,
      period: const Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GifImage(
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                controller: _controller,
                image: Assets.gif.loading.provider(),
              ),
              spaceH12,
              Text(
                'あなたのストレスを\nテスト中',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
