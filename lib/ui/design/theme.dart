import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'my_colors.dart';

final themeProvider = Provider<ThemeData>((ref) {
  final textTheme = TextTheme(
    // headline
    headlineLarge: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.45,
      height: 1.33,
    ),
    headlineMedium: TextStyle(
      fontSize: 27.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3.sp,
      height: 1.33.sp,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15.sp,
      height: 1.33.sp,
    ),
    // title
    titleLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15.sp,
      height: 1.33.sp,
    ),
    titleMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.12.sp,
      height: 1.33.sp,
    ),
    titleSmall: TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.09.sp,
      height: 1.33.sp,
    ),
    // label
    labelLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.12.sp,
      height: 1.33.sp,
    ),
    labelMedium: TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.09.sp,
      height: 1.33.sp,
    ),
    labelSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.06.sp,
      height: 1.33.sp,
    ),
    // body
    bodyLarge: TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.12.sp,
      height: 1.33.sp,
    ),
    bodyMedium: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.09.sp,
      height: 1.33.sp,
    ),
    bodySmall: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.06.sp,
      height: 1.33.sp,
    ),
  );
  return ThemeData(
    //TextFormなどのhintTextの
    primarySwatch: MyColors.materialColor,
    scaffoldBackgroundColor: MyColors.white.color,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: MyColors.materialColor,
      errorColor: MyColors.stateDanger.color,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.white.color,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColors.primary.color,
      ),
      titleTextStyle: TextStyle(
        color: MyColors.primary.color,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: MyColors.beige.color,
      selectedItemColor: MyColors.primary.color,
      unselectedItemColor: MyColors.primary.color,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: textTheme.bodyLarge?.copyWith(
        fontSize: 15,
        color: MyColors.grey300.color,
      ),
      filled: true,
      fillColor: MyColors.grey100.color,
      contentPadding: const EdgeInsets.all(12),
      //focusされている時(?)
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.primary.color,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      // focusされていない時
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.grey150.color,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      errorMaxLines: 3,
      helperMaxLines: 3,
      labelStyle: textTheme.bodyMedium,
      helperStyle: textTheme.bodySmall,
    ),
    fontFamily: 'NotoSansJP',
    textTheme: textTheme,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: MyColors.white.color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: textTheme.labelMedium,
      labelColor: MyColors.grey900.color,
      unselectedLabelColor: MyColors.grey300.color,
      indicatorColor: MyColors.secondaryMain.color,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: MyColors.secondaryMain.color,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
  );
});
