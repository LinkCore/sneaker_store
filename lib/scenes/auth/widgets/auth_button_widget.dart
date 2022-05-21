import 'package:flutter/material.dart';

import '../../../common/app_textstyles.dart';

class AuthButtonWidget extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String text;
  final Future<void> Function() onTap;
  const AuthButtonWidget({Key? key, required this.margin, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Container(
          margin: margin,
          height: MediaQuery.of(context).size.height / 15,
          width: MediaQuery.of(context).size.width / 1,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.buttonTextStyle,
            ),
          )),
      onTap: onTap,
    );
  }
}
