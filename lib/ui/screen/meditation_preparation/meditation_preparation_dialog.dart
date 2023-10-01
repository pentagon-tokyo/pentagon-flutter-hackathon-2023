import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/gen/assets.gen.dart';
import '../../component/accept_button.dart';
import '../../design/spaces.dart';

class MeditationPreparationDialog extends StatelessWidget {
  const MeditationPreparationDialog({
    super.key,
    required this.zazenTime,
  });

  final int zazenTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.sp),
      contentPadding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.sp),
        ),
      ),
      content: SizedBox(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '坐禅の準備',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            spaceH36,
            Text(
              '$zazenTime分',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            spaceH12,
            Text(
              'の瞑想をスタートします！',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            spaceH36,
            _Attention(
              image: Assets.icon.zazen,
              message: 'カメラの枠内に収まるよう坐禅を組みましょう。',
            ),
            spaceH24,
            _Attention(
              image: Assets.icon.halfEyes,
              message: '目は見開かず細めず力を抜いて自然に開きましょう（半眼）。',
            ),
            spaceH24,
            _Attention(
              image: Assets.icon.monk,
              message: '瞑想中、集中力が切れてくると罰警されます。',
            ),
            spaceH36,
            AcceptButton(
              label: '瞑想体験をはじめる',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Attention extends StatelessWidget {
  const _Attention({
    required this.image,
    required this.message,
  });

  final SvgGenImage image;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image.svg(),
        spaceW12,
        Flexible(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}
