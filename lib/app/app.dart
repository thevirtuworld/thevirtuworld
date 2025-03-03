import 'package:flutter/material.dart';
import '../core/constants/app_theme.dart';
import '../core/navigation/app_router.dart';
import '../core/services/service_locator.dart';

class VirtuWorldApp extends StatelessWidget {
  const VirtuWorldApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();

    return MaterialApp.router(
      title: 'TheVirtuWorld',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          ThemeMode.dark, // Default to dark theme for better game experience
      debugShowCheckedModeBanner: false,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
    );
  }
}
