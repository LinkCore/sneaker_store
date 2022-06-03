import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';
import 'package:uiblock/uiblock.dart';

import '../../generated/l10n.dart';
import '../connectivity/connectivity_bloc/connectivity_bloc.dart';
import '../home/home_page.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_page.dart';
import 'widgets/no_connection_page.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  Widget _child = Container();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MultiBlocListener(
          listeners: [
            BlocListener<ConnectivityBloc, ConnectivityState>(
                listener: (context, state) {
              if (state is HasConnectionState) {
                if (state.needToBlock) {
                  UIBlock.unblock(context);
                }
              } else if (state is NoConnectionState) {
                UIBlock.block(context, childBuilder: (context) {
                  return const NoConnectionPage();
                });
              }
            }),
            BlocListener<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AutoLoginState) {
                setState(() {
                  _child = HomePage(userRoles: state.userRole);
                });
              } else if (state is NeedToAuthState) {
                setState(() {
                  _child = const AuthPage();
                });
              } else if (state is AuthErrorState) {
                setState(() {
                  _child = AuthPage(errorText: state.errorText);
                });
              } else if (state is AuthLoadingState) {
                setState(() {
                  _child = Container(
                      color: AppColors.backgroundColor,
                      child: const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor)));
                });
              } else {
                setState(() {
                  _child = Scaffold(
                      backgroundColor: AppColors.backgroundColor,
                      body: Center(
                          child: Text(S.current.invalidState,
                              style: AppTextStyles.plainTextStyle)));
                });
              }
            })
          ],
          child: AnimatedSwitcher(
              child: _child, duration: const Duration(seconds: 1)))
    ]);
  }
}