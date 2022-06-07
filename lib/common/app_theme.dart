import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_text_styles.dart';

import 'app_colors.dart';

class AppTheme {

  static BorderRadius borderRadius = const BorderRadius.all(Radius.circular(15.0));
  static BorderSide borderSideRed = const BorderSide(color: Colors.red);
  static BorderSide borderSideWhite = const BorderSide(color: Colors.white70);

  static ThemeData primaryTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: borderSideRed,
              borderRadius: borderRadius),
          errorBorder: OutlineInputBorder(
              borderSide: borderSideRed,
              borderRadius: borderRadius),
          focusedBorder: OutlineInputBorder(
              borderSide: borderSideWhite,
              borderRadius: borderRadius),
          enabledBorder: OutlineInputBorder(
              borderSide: borderSideWhite,
              borderRadius: borderRadius),
          labelStyle: AppTextStyles.plainTextStyle,
          floatingLabelStyle: AppTextStyles.plainTextStyle));
}
