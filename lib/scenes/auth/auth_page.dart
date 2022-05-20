import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/auth/register_page.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_button.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_textfield.dart';

import '../../common/app_colors.dart';
import '../../common/app_textstyles.dart';
import '../../generated/l10n.dart';
import 'auth_bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? blocErrorText;

  Future<void> onTapSignIn() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      if (blocErrorText != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(blocErrorText!)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Error')),
      );
    }
    context.read<AuthBloc>().add(SignInEvent(
        password: passwordController.text,
        login: loginController.text,
    )
    );
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
                  AuthTextField(
                    labelText: S.current.phoneEmailOrUsername,
                    controller: loginController,
                    isSuffixIcon: false,
                  ),
                  AuthTextField(
                    labelText: S.current.password,
                    controller: passwordController,
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
                  AuthButton(
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