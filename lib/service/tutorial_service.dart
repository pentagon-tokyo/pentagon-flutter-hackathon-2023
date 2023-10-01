import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/shared_key.dart';

final tutorialServiceProvider =
    Provider<TutorialService>((ref) => TutorialService());

class TutorialService {
  // チュートリアル画面の表示有無を返す
  Future<bool> getHasShown() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool(SharedKey.hasShownTourScreen) ?? false;
    debugPrint('tour screen key to $result');
    return result;
  }

  // チュートリアル画面の表示有無をtrueにする
  Future<void> setTrue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedKey.hasShownTourScreen, true);
    debugPrint('Set the value of the tour screen permission key to true');
  }
}
