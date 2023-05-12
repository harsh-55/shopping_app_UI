import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/utils/app_theme.dart';
import 'main_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.appTheme,
    home: MainWrapper(),
  ));
}
