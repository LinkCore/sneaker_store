import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sneaker_store/common/app_text_styles.dart';

class ModalTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? filteringText;

  const ModalTextFieldWidget(
      {Key? key,
      required this.keyboardType,
      required this.labelText,
      required this.controller,
      this.filteringText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
            inputFormatters: filteringText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                alignLabelWithHint: false,
                labelStyle: AppTextStyles.plainTextStyle,
                contentPadding: const EdgeInsets.only(left: 15, right: 15),
                border: InputBorder.none,
                labelText: labelText,
                helperMaxLines: 1),
            controller: controller));
  }
}