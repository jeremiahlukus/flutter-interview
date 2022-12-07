// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/form_style.dart';

class OttoThemes {
  static final base = ThemeData.light();
  static final ThemeData defaultTheme = base.copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    backgroundColor: OttoColor.white,
    scaffoldBackgroundColor: OttoColor.white,
    primaryColor: OttoColor.primary,
    canvasColor: Colors.transparent,
    splashColor: Colors.transparent,
    errorColor: OttoColor.red700,
    highlightColor: Colors.transparent,
    inputDecorationTheme: OttoFormTheme.defaultFormTheme,
    primaryColorBrightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
  );
}
