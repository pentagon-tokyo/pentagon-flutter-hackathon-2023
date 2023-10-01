import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:satorist/service/tutorial_service.dart';
import 'package:satorist/ui/component/image_view.dart';

import '../../component/ripple_effect.dart';
import '../../design/colors.dart';
import '../../design/spaces.dart';
import '../../design/text_styles.dart';
import 'tutorial_page.dart';

/// チュートリアル画

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});
  @override
  State createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late PageController _pageController;
  final _pageChildren = [
    TutorialPage(
      title: 'ハッカソンで疲れた\nあなたへ',
      message: '',
      image: ImageView(
        'assets/image/tutorial1.png',
        ImageType.asset,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    ),
    TutorialPage(
      title: 'ストレスを計測し\n最適な瞑想体験を',
      message: '',
      image: ImageView(
        'assets/image/tutorial2.png',
        ImageType.asset,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    ),
    TutorialPage(
      title: 'SATORISTが\n悟りへと導きます',
      message: '',
      image: ImageView(
        'assets/image/tutorial3.png',
        ImageType.asset,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    ),
  ];
  final _pageIndexSubject = StreamController<int>.broadcast();

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageIndexSubject.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(TutorialScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: PageView(
            onPageChanged: _pageIndexSubject.sink.add,
            controller: _pageController,
            children: _pageChildren,
          ),
        ),
        spaceH32,
        _pagination(),
        spaceH32,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _StartButton(),
        ),
        spaceH40,
      ],
    );
  }

  Widget _pagination() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(
        _pageChildren.length,
        (index) {
          return StreamBuilder<int>(
            initialData: _pageController.initialPage,
            stream: _pageIndexSubject.stream.where(
              (page) => index >= page - 1 && index <= page + 1,
            ),
            builder: (_, AsyncSnapshot<int> snapshot) {
              return Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: snapshot.data == index ? colorWhite : colorGray90,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _StartButton extends ConsumerWidget {
  const _StartButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RippleEffect(
      onTap: () async {
        await ref.read(tutorialServiceProvider).setTrue();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: colorOpacity,
          border: Border.all(color: colorWhite),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          'はじめる',
          style: textStyle(
            const [fontSize15, bold, white],
          ),
        ),
      ),
    );
  }
}
