import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../features/home/presentation/screens/home_screen.dart';

class ChrimastsatastrackerApp extends StatelessWidget {
  final Widget? home;
  final DateTime Function()? clock;

  const ChrimastsatastrackerApp({super.key, this.home, this.clock});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: home ?? HomeScreen(clock: clock),
    );
  }
}
