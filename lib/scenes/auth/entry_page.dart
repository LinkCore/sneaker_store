import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uiblock/uiblock.dart';

import '../../generated/l10n.dart';
import '../connectivity/connectivity_bloc/connectivity_bloc.dart';
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
              print(
                  "============================================================================================================no connection");
              UIBlock.block(context, childBuilder: (context) {
                return AnimatedContainer(
                  color: AppColors.backgroundColor.withOpacity(0.6),
                  duration: const Duration(seconds: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Colors.amber),
                      const SizedBox(width: 10),
                      Center(child: Text(S.current.noInternetConnection, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),)),
                    ],
                  ),
                );
              });
            }
          }),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
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
                        color: Colors.amber,
                      )));
                });
              } else {
                setState(() {
                  _child = Scaffold(
                    backgroundColor: AppColors.backgroundColor,
                    body: Center(
                        child: Text(
                      S.current.invalidState,
                      style: AppTextStyles.labelTextStyle,
                    )),
                  );
                });
              }
            },
          ),
        ],
        child: AnimatedSwitcher(
          child: _child,
          duration: const Duration(seconds: 1),
        ),
      ),
    ]);
  }
}
