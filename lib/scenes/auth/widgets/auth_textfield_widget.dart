import 'package:flutter/material.dart';

import '../../../common/app_text_styles.dart';
import '../../../generated/l10n.dart';

class CommonTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isSuffixIcon;
  final TextInputType keyboard;

  const CommonTextFieldWidget(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.isSuffixIcon,
      required this.keyboard})
      : super(key: key);

  @override
  State<CommonTextFieldWidget> createState() => _CommonTextFieldWidgetState();
}

class _CommonTextFieldWidgetState extends State<CommonTextFieldWidget> {
  bool get isObscure => widget.isSuffixIcon;
  IconData visibilityIcon = Icons.visibility_off;
  bool visibility = true;

  Widget? _suffixIcon() {
    if (widget.isSuffixIcon == true) {
      return InkResponse(
          radius: 25,
          child: Icon(visibilityIcon, color: Colors.blue),
          onTap: () {
            setState(() {
              visibility = !visibility;
              if (!visibility) {
                visibilityIcon = Icons.visibility;
              } else {
                visibilityIcon = Icons.visibility_off;
              }
            });
          });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.current.pleaseEnterSomeText;
              } else if (value.length < 4) {
                return S.current.pleaseEnterMoreThanThreeCharacters;
              }
              return null;
            },
            obscureText: isObscure ? visibility : isObscure,
            decoration: InputDecoration(
                suffixIcon: _suffixIcon(),
                border: InputBorder.none,
                labelText: widget.labelText),
            controller: widget.controller,
            style: AppTextStyles.plainTextStyle,
            keyboardType: widget.keyboard));
  }
}
