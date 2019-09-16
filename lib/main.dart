import 'package:flutter/material.dart';
import 'package:ponyvie/shared/theme/app_theme.dart';
import 'app.dart';

void main() => runApp(
  MyApp()
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.appTheme(),
        home: Home()
      );
  }
}