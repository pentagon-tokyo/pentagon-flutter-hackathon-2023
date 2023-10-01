import 'package:logger/logger.dart';

// REF: https://pub.dev/packages/logger
// log.t("Trace log");
// log.d("Debug log");
// log.i("Info log");
// log.w("Warning log");
// log.e("Error log", error: 'Test Error');
// log.f("What a fatal log", error: error, stackTrace: stackTrace);

final log = Logger(
  printer: PrettyPrinter(
    printEmojis: false,
  ),
);
