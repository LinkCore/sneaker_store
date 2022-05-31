import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  static TextStyle mainTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.backgroundColor);
  static TextStyle subMainTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w300, fontSize: 16);

  static TextStyle gridCountPriceTextStyle = mainTextStyle.merge(GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 15));
  static TextStyle editProductNameTextStyle = mainTextStyle.merge(GoogleFonts.poppins(fontWeight: FontWeight.w800, color: Colors.white));
  static TextStyle alertApproveTextStyle = GoogleFonts.poppins( fontWeight: FontWeight.w700, color: AppColors.primaryColor);
  static TextStyle gridCountModelTextStyle = mainTextStyle.merge(GoogleFonts.poppins(fontWeight: FontWeight.w400));
  static TextStyle backgroundRolesSwitcherTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(fontWeight: FontWeight.w400));
  static TextStyle buttonTextStyle = mainTextStyle.merge(GoogleFonts.poppins(fontSize: 18));
  static TextStyle titleTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(fontSize: 34));
  static TextStyle floatingRolesSwitcherTextStyle = mainTextStyle.merge(GoogleFonts.poppins(color: Colors.white));
  static TextStyle noConnectionTextStyle = mainTextStyle.merge(GoogleFonts.poppins(color: Colors.white, fontSize: 12));
  static TextStyle totalCostTextStyle = mainTextStyle.merge(GoogleFonts.poppins(color: Colors.white, fontSize: 22));
  static TextStyle buyingSuccessTextStyle = mainTextStyle.merge(GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500));

  static TextStyle subTitleTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(fontSize: 30));
  static TextStyle productModalTitleTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(fontSize: 20));
  static TextStyle brandFilterTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(fontSize: 24));
  static TextStyle descriptionTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(fontSize: 14, color: AppColors.helperColor));
  static TextStyle sizeGuideTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(color: AppColors.helperColor));
  static TextStyle pleaseAddedSomeProductsTextStyle = subMainTextStyle.merge(GoogleFonts.poppins(fontSize: 12));

  static TextStyle tappedTextStyle = mainTextStyle.merge(GoogleFonts.poppins(color: AppColors.actionButtonColor));
  static TextStyle applyTextStyle = mainTextStyle.merge(GoogleFonts.poppins(color: AppColors.primaryColor));

  static TextStyle sizedListTextStyle = GoogleFonts.poppins(color: AppColors.helperColor, fontWeight: FontWeight.w500, fontSize: 20);
  static TextStyle productListTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 22);
  static TextStyle cartIsEmptyTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18);
  static TextStyle albumNameTextStyle = GoogleFonts.poppins(fontSize: 14);
  static TextStyle yourCartTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w400);
  static TextStyle priceTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 24);
  static TextStyle plainTextStyle = GoogleFonts.poppins();
}