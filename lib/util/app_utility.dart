import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/services.dart';

import '../util/log.dart';

class AppUtility {
  static bool isDebugMode() {
    if (foundation.kDebugMode) {
      log.d('app DEBUG mode');
      return true;
    } else {
      log.d('App RELEASE mode');
      return false;
    }
  }

  /// blocks rotation; sets orientation to: portrait
  static void portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
