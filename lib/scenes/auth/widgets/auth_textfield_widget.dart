import 'package:flutter/material.dart';
import '../../../common/app_textstyles.dart';
import '../../../generated/l10n.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isSuffixIcon;
  final TextInputType keyboard;

  const AuthTextFieldWidget({Key? key, required this.labelText, required this.controller, required this.isSuffixIcon, required this.keyboard}) : super(key: key);

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {

  bool get isObscure => widget.isSuffixIcon;
  IconData visibilityIcon = Icons.visibility_off;
  bool visibility = true;

  Widget? _suffixIcon()  {
    if (widget.isSuffixIcon == true) {
      return InkResponse(
        radius: 25,
        child: Icon(
        visibilityIcon,
        color: Colors.blue,
        ),
        onTap: () {
          setState(() {
            visibility =! visibility;
            if (!visibility) {
              visibilityIcon = Icons.visibility;
            } else {
              visibilityIcon = Icons.visibility_off;
            }
          });
        },
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        validator: (value){
          if (value == null || value.isEmpty) {
            return S.current.pleaseEnterSomeText;
          }
          else if(value.length < 4){
            return S.current.pleaseEnterMoreThanThreeCharacters;
          }
          return null;
        },
        obscureText: isObscure? visibility : isObscure,
        decoration: InputDecoration(
          suffixIcon: _suffixIcon(),
          border: InputBorder.none,
          labelText: widget.labelText,
        ),
        controller: widget.controller,
        style: AppTextStyles.labelTextStyle,
        keyboardType: widget.keyboard,
      ),
    );
  }
}
