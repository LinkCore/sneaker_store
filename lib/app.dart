import 'package:flutter/material.dart';

import 'common/app_theme.dart';

class SneakerStoreApp extends StatelessWidget {
  const SneakerStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.primaryTheme,
    );
  }
}