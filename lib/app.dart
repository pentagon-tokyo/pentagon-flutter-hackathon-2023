import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahha_flutter/sahha_flutter.dart';

import 'util/app_router.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});
  @override
  ConsumerState createState() {
    return _AppState();
  }
}

class _AppState extends ConsumerState<App> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Use custom values
    SahhaFlutter.configure(
      environment: SahhaEnvironment.sandbox, // Required - .sandbox for testing
      // sensors: [SahhaSensor.device] // Optional - defaults to all sensors
    )
        .then(
          (success) => {debugPrint(success.toString())},
        )
        .catchError(
          (dynamic error, stackTrace) => {debugPrint(error.toString())},
        );
    // 認証
    SahhaFlutter.authenticate(
      appId: dotenv.get('APP_ID'),
      appSecret: dotenv.get('APP_SECRET'),
      externalId: dotenv.get('EXTERNAL_ID'),
    )
        .then(
          (success) => {debugPrint(success.toString())},
        )
        .catchError(
          (dynamic error, stackTrace) => {debugPrint(error.toString())},
        );
  }

  @override
  Widget build(BuildContext context) {
    return _app();
  }

  Widget _app() {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // 開発基準サイズ Figmaのサイズとしています
      builder: (context, _) {
        return GestureDetector(
          onTap: () {
            // キーボードが出ている時に、フォーカスされているところ以外をタップした時に、キーボードを隠す
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: MaterialApp.router(
            // テーマ設定
            // theme: themeData,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ja'),
            ],
            // ルーティング設定
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
