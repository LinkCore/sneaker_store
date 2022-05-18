import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/auth/auth_bloc/auth_bloc.dart';

import 'common/app_theme.dart';

class SneakerStoreApp extends StatelessWidget {
  const SneakerStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        theme: AppTheme.primaryTheme,
      ),
    );
  }
}
