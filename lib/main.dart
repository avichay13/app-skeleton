import 'package:app_name/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:app_name/ui/home_screen/home_screen.dart';
import 'package:app_name/ui/landing_screen/landing_screen.dart';
import 'package:app_name/ui/login_screen/login_screen.dart';
import 'package:app_name/theme/custom_theme.dart';

void main() {
  setupLocator();
  runApp(AppMain());
}

class AppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Name',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => Landing(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
      },
    );
  }
}