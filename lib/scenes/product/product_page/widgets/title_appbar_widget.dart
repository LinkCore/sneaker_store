import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_text_styles.dart';

class TitleAppBarWidget extends StatelessWidget {
  final String productName;

  const TitleAppBarWidget({Key? key, required this.productName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            Text(productName, style: AppTextStyles.editProductNameTextStyle));
  }
}