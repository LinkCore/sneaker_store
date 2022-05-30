import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

import '../../generated/l10n.dart';
import '../home/home_page.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_page.dart';
import 'no_connection_page.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  Widget _child = Container();

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch(e){
      print(e.toString());
      return;
    }
    if(!mounted){
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  initState() {
    super.initState();
    initConnectivity();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AutoLoginState) {
          if (_connectivityResult == ConnectivityResult.none) {
            _child = const NoConnectionPage();
          } else {
            setState(() {
              _child = HomePage(userRoles: state.userRole);
            });
          }
        } else if (state is NeedToAuthState) {
          if (_connectivityResult == ConnectivityResult.none) {
            _child = const NoConnectionPage();
          } else {
            setState(() {
            _child = const AuthPage();
          });
          }
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
      child: AnimatedSwitcher(
        child: _child,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
