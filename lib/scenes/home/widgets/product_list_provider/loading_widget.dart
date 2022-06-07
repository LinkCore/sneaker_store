import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Container(
              color: AppColors.backgroundColor,
              child: const CircularProgressIndicator(
                  backgroundColor: AppColors.backgroundColor,
                  color: AppColors.primaryColor))
        ]));
  }
}