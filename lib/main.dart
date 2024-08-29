import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_theme.dart';

import 'presentation/splash/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage()
    );
  }
}
