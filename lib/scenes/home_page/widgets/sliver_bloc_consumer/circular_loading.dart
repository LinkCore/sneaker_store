import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          color: AppColors.backgroundColor,
          child: const CircularProgressIndicator(
              backgroundColor: AppColors.backgroundColor,
              color: Colors.amber
          )
      ),
    );
  }
}
