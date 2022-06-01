import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sneaker_store/app_routes.dart';
import 'package:flutter_sneaker_store/scenes/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_sneaker_store/scenes/auth/entry_page.dart';
import 'package:flutter_sneaker_store/scenes/cart/cart_bloc/cart_bloc.dart';
import 'package:flutter_sneaker_store/scenes/connectivity/connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter_sneaker_store/scenes/product/product_bloc/product_bloc.dart';

import 'common/app_theme.dart';
import 'generated/l10n.dart';

class SneakerStoreApp extends StatelessWidget {
  const SneakerStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityBloc>(
              create: (context) =>
                  ConnectivityBloc()..add(StartupConnectionCheck())),
          BlocProvider<CartBloc>(create: (context) => CartBloc()),
          BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
          BlocProvider<AuthBloc>(
              create: (context) => AuthBloc()..add(StartupEvent()))
        ],
        child: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [Locale('en', ''), Locale('ru', '')],
            initialRoute: AppRoutes.entryPage,
            routes: {AppRoutes.entryPage: (context) => const EntryPage()},
            debugShowCheckedModeBanner: false,
            theme: AppTheme.primaryTheme));
  }
}
