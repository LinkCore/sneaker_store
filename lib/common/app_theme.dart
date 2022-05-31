import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData primaryTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(15.0))),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius:  BorderRadius.all(Radius.circular(15.0))),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white70),  borderRadius:  BorderRadius.all(Radius.circular(15.0))),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white70),  borderRadius:  BorderRadius.all(Radius.circular(15.0))),
        labelStyle: AppTextStyles.plainTextStyle,
        floatingLabelStyle: AppTextStyles.plainTextStyle
      ));
}
