import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';

import 'auth/auth_bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        actions: [
          InkWell(
              child: const Icon(
                Icons.login,
                color: Colors.white70,
              ),
              onTap: () {
                context.read<AuthBloc>().add(SignOutEvent());
              }),
        ],
      ),
      body: const Center(
        child: Text('HomePage'),
      ),
    );
  }
}
