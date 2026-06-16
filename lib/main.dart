import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/splash_screen.dart';

void main() {
  runApp(const VSphereERP());
}

class VSphereERP extends StatelessWidget {
  const VSphereERP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VSphere ERP',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}