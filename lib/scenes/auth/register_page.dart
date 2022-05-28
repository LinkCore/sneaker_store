import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_textfield_widget.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/bootom_sheet_anchor.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/roles_swither_widget.dart';

import '../../common/app_textstyles.dart';
import '../../core/user/roles.dart';
import '../../generated/l10n.dart';
import 'auth_bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  final String? errorText;

  const RegisterPage({Key? key, required this.errorText}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Roles roleValue = Roles.buyer;
  bool isOnTap = true;

  Future<void> onTapRegister() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              S.current.processingData,
              style: AppTextStyles.labelTextStyle,
            )),
      );
      if (widget.errorText != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                widget.errorText!,
                style: AppTextStyles.labelTextStyle,
              )),
        );
      }
      context.read<AuthBloc>().add(RegisterUserEvent(
        login: loginController.text,
        password: passwordController.text,
        roles: roleValue,
      ));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              S.current.dataError,
              style: AppTextStyles.labelTextStyle,
            )),
      );
    }
  }

  void onTapRolesSwitcher() {
    setState(() {
      isOnTap = !isOnTap;
    });
    if (isOnTap) {
      setState(() {
        roleValue = Roles.buyer;
      });
    } else {
      setState(() {
        roleValue = Roles.seller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (BuildContext builder, ScrollController scrollController) {
        return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                setState(() {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          state.errorText,
                          style: AppTextStyles.labelTextStyle,
                        )),
                  );
                });
              }
            },
            child: Align(
              child: Form(
                key: _formKey,
                child: Container(

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 1,
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35)),
                       color: AppColors.backgroundColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BottomSheetAnchor(
                          margin: EdgeInsets.only(
                              left: 140, right: 140, bottom: 10, top: 10),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 20),
                          child: Text(
                            S.current.createAccount,
                            style: AppTextStyles.subTitleTextStyle,
                          ),
                        ),
                        RolesSwitcherWidget(
                          leftText: S.current.buyer,
                          rightText: S.current.seller,
                          backgroundColor: Colors.white.withOpacity(0.07),
                          floatingWidgetColor: Colors.blue,
                          backgroundTextStyle:
                          AppTextStyles.backgroundRolesSwitcherTextStyle,
                          floatingWidgetTextStyle:
                          AppTextStyles.floatingRolesSwitcherTextStyle,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 17,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.24,
                          onTap: onTapRolesSwitcher,
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 18,
                        ),
                        AuthTextFieldWidget(
                          labelText: S.current.email,
                          controller: loginController,
                          keyboard: TextInputType.emailAddress,
                          isSuffixIcon: false,
                        ),
                        AuthTextFieldWidget(
                          labelText: S.current.password,
                          controller: passwordController,
                          keyboard: TextInputType.text,
                          isSuffixIcon: true,
                        ),
                        const Spacer(),
                        AuthButtonWidget(
                          margin: const EdgeInsets.only(bottom:40),
                          text: S.current.register,
                          onTap: onTapRegister,
                        ),
                      ],
                    )),
              ),
            ));
      },
      expand: false,
      initialChildSize: 1,
    );
  }
}
