import 'package:flutter/material.dart';
import 'app_constants.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const Scaffold(body: Center(child: Text(AppConstants.appName))),
    );
  }
}
