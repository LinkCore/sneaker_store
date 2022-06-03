import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

class ErrorTextWidget extends StatelessWidget {
  final String text;

  const ErrorTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            color: AppColors.backgroundColor,
            child: Center(
                child: Text(text,
                    style: AppTextStyles.backgroundRolesSwitcherTextStyle))));
  }
}