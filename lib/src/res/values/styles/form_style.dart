import 'package:flutter/material.dart';

class OttoFormTheme {
  static const UnderlineInputBorder _outlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  static const InputDecorationTheme _ottoFormTheme = InputDecorationTheme(
    border: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    focusedBorder: _outlineInputBorder,
    disabledBorder: _outlineInputBorder,
    errorBorder: _outlineInputBorder,
    focusedErrorBorder: _outlineInputBorder,
  );

  static InputDecorationTheme get defaultFormTheme => _ottoFormTheme;
}
