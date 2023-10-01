import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'flavors.dart';
import 'repository/remote_push_notification_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
      name: 'PROD',
      color: Colors.red,
      location: BannerLocation.bottomStart,
      variables: {
        'baseUrl': 'https://example.com',
      });
  F.appFlavor = Flavor.PROD;
  runApp(ProviderScope(child: App()));
}
