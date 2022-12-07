import 'package:flutter/material.dart';

class OttoColor {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  OttoColor._();

  //WHITE & BLACK.
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  //LIGHT
  static const Color light300 = Color(0xFFFEFEFF);
  static const Color subtleText300 = Color(0xFFE2E2E7);

  //NEUTRAL
  static const Color neutral900 = Color(0xFF061523);
  static const Color neutral800 = Color(0xFF122535);
  static const Color neutral700 = Color(0xFF2E4457);
  static const Color neutral600 = Color(0xFF687987);
  static const Color neutral500 = Color(0xFF98A7B4);
  static const Color neutral400 = Color(0xFFC2CDD6);
  static const Color neutral300 = Color(0xFFD9E1E8);
  static const Color neutral200 = Color(0xFFE4EBF1);
  static const Color neutral100 = Color(0xFFEDF2F7);
  static const Color neutral50 = Color(0xFFF5F7FA);

  //PRIMARY BLUE
  static const Color primaryBlue900 = Color(0xFF003677);
  static const Color primaryBlue800 = Color(0xFF004599);
  static const Color primaryBlue700 = Color(0xFF0356BB);
  static const Color primaryBlue600 = Color(0xFF006CF0);
  static const Color primaryBlue500 = Color(0xFF2285FF);
  static const Color primaryBlue400 = Color(0xFF64AAFF);
  static const Color primaryBlue300 = Color(0xFFA6CEFF);
  static const Color primaryBlue200 = Color(0xFFD1E6FF);
  static const Color primaryBlue100 = Color(0xFFE5F1FF);

  //SECONDARY
  static const Color secondary900 = Color(0xFF005B77);
  static const Color secondary800 = Color(0xFF007599);
  static const Color secondary700 = Color(0xFF0390BB);
  static const Color secondary600 = Color(0xFF00B8F0);
  static const Color secondary500 = Color(0xFF22CBFF);
  static const Color secondary400 = Color(0xFF64DBFF);
  static const Color secondary300 = Color(0xFFA6EAFF);
  static const Color secondary200 = Color(0xFFD1F4FF);
  static const Color secondary100 = Color(0xFFE9FAFF);

  //YELLOW
  static const Color yellow900 = Color(0xFF805500);
  static const Color yellow800 = Color(0xFFA87000);
  static const Color yellow700 = Color(0xFFD78F00);
  static const Color yellow600 = Color(0xFFFFAD0A);
  static const Color yellow500 = Color(0xFFFFC042);
  static const Color yellow400 = Color(0xFFFFD175);
  static const Color yellow300 = Color(0xFFFFE2A8);
  static const Color yellow200 = Color(0xFFFFECC7);
  static const Color yellow100 = Color(0xFFFFF7E6);

  //ORANGE
  static const Color orange900 = Color(0xFFA83D00);
  static const Color orange800 = Color(0xFFC24600);
  static const Color orange700 = Color(0xFFE55300);
  static const Color orange600 = Color(0xFFFF660F);
  static const Color orange500 = Color(0xFFFF7F36);
  static const Color orange400 = Color(0xFFFFA470);
  static const Color orange300 = Color(0xFFFFBE99);
  static const Color orange200 = Color(0xFFFFD8C2);
  static const Color orange100 = Color(0xFFFFECE0);

  //RED
  static const Color red900 = Color(0xFF700D00);
  static const Color red800 = Color(0xFF8A1000);
  static const Color red700 = Color(0xFFA31300);
  static const Color red600 = Color(0xFFB81500);
  static const Color red500 = Color(0xFFE01A00);
  static const Color red400 = Color(0xFFFF705E);
  static const Color red300 = Color(0xFFFFA195);
  static const Color red200 = Color(0xFFFFC3BD);
  static const Color red100 = Color(0xFFFFF1F0);

  //GREEN
  static const Color green900 = Color(0xFF012816);
  static const Color green800 = Color(0xFF02361D);
  static const Color green700 = Color(0xFF024525);
  static const Color green600 = Color(0xFF046235);
  static const Color green500 = Color(0xFF05944F);
  static const Color green400 = Color(0xFF06BC64);
  static const Color green300 = Color(0xFF6CE5AA);
  static const Color green200 = Color(0xFFA2FBD0);
  static const Color green100 = Color(0xFFE2FEF0);

  //DARK
  static const Color dark900 = Color(0xFF0E0E2C);

  static const MaterialColor primary = MaterialColor(
    0xFF003677,
    <int, Color>{
      50: Color.fromRGBO(48, 141, 255, 0.1),
      100: Color.fromRGBO(48, 141, 255, 0.2),
      200: Color.fromRGBO(48, 141, 255, 0.3),
      300: Color.fromRGBO(48, 141, 255, 0.4),
      400: Color.fromRGBO(48, 141, 255, 0.5),
      500: Color.fromRGBO(48, 141, 255, 0.6),
      600: Color.fromRGBO(48, 141, 255, 0.7),
      700: Color.fromRGBO(48, 141, 255, 0.8),
      800: Color.fromRGBO(48, 141, 255, 0.9),
      900: Color.fromRGBO(48, 141, 255, 1),
    },
  );

  static const MaterialColor secondary = MaterialColor(
    0xFF005B77,
    <int, Color>{
      50: Color.fromRGBO(92, 318, 255, 0.1),
      100: Color.fromRGBO(92, 318, 255, 0.2),
      200: Color.fromRGBO(92, 318, 255, 0.3),
      300: Color.fromRGBO(92, 318, 255, 0.4),
      400: Color.fromRGBO(92, 318, 255, 0.5),
      500: Color.fromRGBO(92, 318, 255, 0.6),
      600: Color.fromRGBO(92, 318, 255, 0.7),
      700: Color.fromRGBO(92, 318, 255, 0.8),
      800: Color.fromRGBO(92, 318, 255, 0.9),
      900: Color.fromRGBO(92, 318, 255, 1),
    },
  );
}
