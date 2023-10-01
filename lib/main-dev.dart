import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'flavors.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
      name: 'DEV',
      color: Colors.red,
      location: BannerLocation.bottomStart,
      variables: {
        'baseUrl': 'https://pokeapi.co',
      });
  F.appFlavor = Flavor.DEV;
  runApp(ProviderScope(child: App()));
}
