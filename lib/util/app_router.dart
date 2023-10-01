import 'package:go_router/go_router.dart';

import '../ui/screen/meditation_result/meditation_result_screen.dart';
import '../ui/screen/start/start_screen.dart';
import '../ui/screen/stress_check_loading/stress_check_loading_screen.dart';
import '../ui/screen/stress_check_result/stress_check_result_screen.dart';
import '../ui/screen/tutorial/tutorial_screen.dart';
import '../ui/vision_detector_views/face_detector_screen.dart';

class AppRouter {
  /// 画面パス[デバッグ]
  static const String debug = '/debug';

  /// 画面パス[スタート]
  static const String start = '/start';

  /// 画面パス[スタート]
  static const String faceDetector = '/face_detector';

  /// 画面パス[チュートリアル]
  static const String tutorial = '/tutorial';

  /// 画面パス[ストレステスト中]
  static const String stressLoading = '/stress_loading';

  /// 画面パス[ストレスチェック結果]
  static const String stressResult = '/stress_result';

  /// 画面パス[瞑想完了]
  static const String zazenSuccess = '/zazen_success';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      // 開発画面
      GoRoute(
        path: '/',
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: AppRouter.faceDetector,
        builder: (context, state) => const FaceDetectorScreen(),
      ),
      GoRoute(
        path: AppRouter.stressResult,
        builder: (context, state) => const StressCheckResultScreen(),
      ),
      // スタート画面
      GoRoute(
        path: AppRouter.start,
        builder: (context, state) => const StartScreen(),
      ),
      // チュートリアル画面
      GoRoute(
        path: AppRouter.tutorial,
        builder: (context, state) => const TutorialScreen(),
      ),
      // ストレステスト中
      GoRoute(
        path: AppRouter.stressLoading,
        builder: (context, state) => const StressCheckLoadingScreen(),
      ),
      // ストレスチェック結果
      GoRoute(
        path: AppRouter.stressResult,
        builder: (context, state) => const StressCheckResultScreen(),
      ),
      // 瞑想完了
      GoRoute(
        path: AppRouter.zazenSuccess,
        builder: (context, state) => const MeditationResultScreen(),
      ),
    ],
  );
}
