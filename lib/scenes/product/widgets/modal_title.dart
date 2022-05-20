import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

class ModalTitle extends StatelessWidget {
  final String titleText;

  const ModalTitle({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40, top: 5),
      child: Text(
        titleText,
        style: AppTextStyles.productModalTitleTextStyle,
      ),
    );
  }
}