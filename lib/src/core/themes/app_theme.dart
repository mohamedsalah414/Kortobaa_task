import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/core/utils/app_values.dart';

import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import 'color_schemes.g.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    fontFamily: AppStrings.appFont,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.primary,
      titleTextStyle: TextStyle(
          color: AppColor.textGrey, fontWeight: FontWeightManger.bold, fontSize: 14),
    ),
    textTheme: const TextTheme().apply(
      fontFamily: AppStrings.appFont,
    ),
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: AppColor.background,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeightManger.medium,
          color: AppColor.textGrey),
      hintStyle: const TextStyle(
          color: AppColor.textGrey, fontSize: 14, fontWeight: FontWeightManger.bold,),
      errorStyle: const TextStyle(
          fontSize: 12, fontWeight:  FontWeightManger.medium, color: AppColor.red),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColor.cyan, width: 2)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColor.cyan, width: 2)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.cyan, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.red, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
  static ThemeData darkThemeData = ThemeData(
    fontFamily: AppStrings.appFont,
    brightness: Brightness.dark,
    // primaryColor: AppColor.primaryBLue,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      // backgroundColor: AppColor.backgroundBLue,
      titleTextStyle: TextStyle(
          color: AppColor.white, fontWeight: FontWeight.w500, fontSize: 20),
    ),
    useMaterial3: true,
    colorScheme: darkColorScheme,
    // scaffoldBackgroundColor: AppColor.backgroundBLue,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColor.primary),
      hintStyle: const TextStyle(
          color: AppColor.cyan, fontSize: 14, fontWeight: FontWeight.w500),
      errorStyle: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w400, color: AppColor.red),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: AppColor.cyan)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: AppColor.cyan)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.cyan, width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.red, width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  );
}
