import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/auth/register_page.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_textfield_widget.dart';

import '../../common/app_colors.dart';
import '../../common/app_textstyles.dart';
import '../../core/user/roles.dart';
import '../../generated/l10n.dart';
import 'auth_bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  final String? errorText;
  final Roles? userRole;
  const AuthPage({Key? key, this.errorText, this.userRole}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<void> onTapSignIn() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.processingData, style: AppTextStyles.labelTextStyle,)),
      );
      if (widget.errorText != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.errorText!, style: AppTextStyles.labelTextStyle,)),
        );
      }
      context.read<AuthBloc>().add(
          SignInEvent(
        password: passwordController.text,
        login: loginController.text,
        userRole: widget.userRole,
          )
      );

    } else { ScaffoldMessenger.of(context)
        .removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.dataError, style: AppTextStyles.labelTextStyle,)),

      );
    }
  }

  Future<void> onTapRegister() async {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return const RegisterPage();
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35, top: 70),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.letsSignYouIn,
                    style: AppTextStyles.titleTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 140),
                    child: Text(
                      S.current.welcomeBackWeMissedYou,
                      style: AppTextStyles.subTitleTextStyle,
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.current.dontHaveAnAccount,
                        style: AppTextStyles.questionTitleTextStyle,
                      ),
                      InkWell(
                          child: Text(
                            S.current.register,
                            style: AppTextStyles.tappedTextStyle,
                          ),
                          onTap: onTapRegister,
                      ),
                    ],
                  ),
                  AuthButtonWidget(
                    margin: const EdgeInsets.only(top: 20, bottom: 50),
                    text: S.current.signIn,
                    onTap: onTapSignIn,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
