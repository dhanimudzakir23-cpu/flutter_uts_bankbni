import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/screens/shell.dart';

class BniMobileApp extends StatelessWidget {
  const BniMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BNI MOBILE PAY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal, primary: AppColors.teal),
        scaffoldBackgroundColor: Colors.white,
        snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          foregroundColor: AppColors.text,
          centerTitle: true,
        ),
      ),
      home: const Shell(),
    );
  }
}
