// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahha_flutter/sahha_flutter.dart';

final stressCheckResultProvider = AutoDisposeFutureProvider<int>(
  (ref) => ref.read(sahhaServiceProvider).checkStress(),
);

final sahhaServiceProvider = AutoDisposeProvider<SahhaService>(
  (ref) => SahhaService(),
);

class SahhaService {
  Future<int> checkStress() async {
    final week = DateTime.now().subtract(const Duration(days: 7));
    return SahhaFlutter.analyzeDateRange(
      startDate: week,
      endDate: DateTime.now(),
    ).then(
      (value) async {
        await Future<void>.delayed(const Duration(seconds: 3));
        debugPrint(value);
        // 起動後分析に24時間かかるため、デモ用に仮JSON返す。
        final loadData =
            await rootBundle.loadString('assets/json/sample1.json');
        final dynamic jsonResponse = json.decode(loadData);
        final array = jsonResponse['inferences'];
        final stressResilience = array.first;
        final score = stressResilience['score'];
        final stressLevel = 100 - double.parse('$score') * 100;
        return stressLevel.toInt();
        // status code 204
        // The analysis engine requires a minimum amount of device sensor data
        // to be uploaded and processed before an analysis can be determined.
        // If you call analyze for a new user profile or a user
        // that has been inactive lately, it's possible for the response
        // to be 204 No Content. This is not an error.
        // You will need to wait and try again every 24 hours
        // until an analysis is available.
      },
    ).catchError(
      (dynamic error, stackTrace) {
        debugPrint(error.toString());
        return -1;
      },
    );
  }
}

extension IntExt on int {
  int get time {
    if (0 <= this && this <= 20) {
      return 5;
    } else if (21 <= this && this <= 40) {
      return 10;
    } else if (41 <= this && this <= 60) {
      return 15;
    } else if (61 <= this && this <= 80) {
      return 20;
    } else if (81 <= this && this <= 100) {
      return 30;
    } else {
      return 0;
    }
  }

  int get timeMillisecond {
    return time * 60 * 1000;
  }

  String get title {
    if (0 <= this && this <= 20) {
      return '優しい道';
    } else if (21 <= this && this <= 40) {
      return '普通の道';
    } else if (41 <= this && this <= 60) {
      return 'きつい道';
    } else if (61 <= this && this <= 80) {
      return '鬼の道';
    } else if (81 <= this && this <= 100) {
      return '修羅の道';
    } else {
      return '';
    }
  }
}
