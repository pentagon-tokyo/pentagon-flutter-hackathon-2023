import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:go_router/go_router.dart';

import '../../../util/app_router.dart';

/// レイアウト確認用ページ
class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('レイアウト確認用${FlavorConfig.instance.name ?? ''}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // チュートリアル画面
            getTransitionButton(context, AppRouter.tutorial, 'チュートリアル画面'),
            getTransitionButton(context, AppRouter.start, 'スタート画面'),
            getTransitionButton(context, AppRouter.stressLoading, 'ストレステスト中'),
            getTransitionButton(context, AppRouter.stressResult, 'ストレスチェック結果'),
            getTransitionButton(context, AppRouter.zazenSuccess, '瞑想完了'),
            getTransitionButton(context, AppRouter.faceDetector, '顔検知'),
          ],
        ),
      ),
    );
  }

  /// 画面遷移ボタンを生成
  Widget getTransitionButton(
    BuildContext context,
    String path,
    String name, {
    dynamic args,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => GoRouter.of(context).push(path, extra: args),
        child: Text(name),
      ),
    );
  }

  /// ダイアログ表示ボタンを生成
  Widget getDialogButton(
    String name,
    VoidCallback callBack,
  ) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => callBack(),
        child: Text(name),
      ),
    );
  }
}
