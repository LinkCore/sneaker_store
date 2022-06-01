import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

class ModalTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> filteringText;

  const ModalTextFieldWidget(
      {Key? key,
      required this.keyboardType,
      required this.labelText,
      required this.controller,
      required this.filteringText})
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
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                border: InputBorder.none,
                labelText: labelText,
                helperMaxLines: 1),
            style: AppTextStyles.plainTextStyle,
            controller: controller));
  }
}
