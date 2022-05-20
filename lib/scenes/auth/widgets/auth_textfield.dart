import 'package:flutter/material.dart';

import '../../../common/app_textstyles.dart';

class AuthTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isSuffixIcon;

  const AuthTextField({Key? key, required this.labelText, required this.controller, required this.isSuffixIcon}) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {

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
            return 'Please enter some text';
          }
          else if(value.length < 4){
            return 'Please enter more than three characters';
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
      ),
    );
  }
}
