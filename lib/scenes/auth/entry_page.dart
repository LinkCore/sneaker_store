import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';

import '../home/home_page.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_page.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  Widget _child = Container();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AutoLoginState) {
          setState(() {
            _child =  const HomePage();
          });
        } else if (state is NeedToAuthState || state is AuthErrorState) {
          setState(() {
            _child = const AuthPage();
          });
        } else if (state is AuthLoadingState) {
          setState(() {
            _child = const Center(child: CircularProgressIndicator());
          });
        } else {
          setState(() {
            _child = const Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: Center(child: Text('State?')),
            );
          });
        }
      },
      child: AnimatedSwitcher(
        child: _child,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
