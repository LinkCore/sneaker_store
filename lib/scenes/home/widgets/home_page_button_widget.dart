import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';

class HomePageButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String heroTag;
  final IconData icon;

  const HomePageButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.heroTag,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: AppColors.primaryColor,
        child: Icon(icon, size: 26));
  }
}