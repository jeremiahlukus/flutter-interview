import 'package:flutter/material.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/scaler/scaler.dart';

enum OttoFontWeight { bold, medium, regular }

class OttoFont {
  OttoFont._();

  static const dmSans = "DMSans";

  static FontWeight fontWeight([OttoFontWeight? ottoFontWeight]) {
    switch (ottoFontWeight) {
      case OttoFontWeight.bold:
        return FontWeight.w700;
      case OttoFontWeight.medium:
        return FontWeight.w500;
      case OttoFontWeight.regular:
        return FontWeight.w400;
      default:
        return FontWeight.w400;
    }
  }

  ///When height is non-null,
  ///the line height of the span of text will be a multiple of fontSize
  /// and be exactly fontSize * height logical pixels tall.
  /// DOCS reference: https://api.flutter.dev/flutter/painting/TextStyle/height.html
  ///
  ///if want to have height 24.0, with font-size 20.0, we should have height property 1,2.
  /// (height/font-size)
  ///

  //H0
  static const num _h0fontSize = 48.0;
  static num get _h0LineHeight => (64.0 / _h0fontSize); //1.3

  //H1
  static const num _h1fontSize = 32.0;
  static get _h1LineHeight => (48.0 / _h1fontSize); //1.5

  //H2
  static const num _h2fontSize = 24.0;
  static num get _h2LineHeight => (32.0 / _h2fontSize); //1.3

  //H3
  static const num _h3fontSize = 20.0;
  static num get _h3LineHeight => (28.0 / _h3fontSize); //1.4

  //H4
  static const num _h4fontSize = 16.0;
  static num get _h4LineHeight => (24.0 / _h4fontSize); //1.5

  //Body
  static const num _bodyfontSize = 14.0;
  static num get _bodyLineHeight => (20.0 / _bodyfontSize); //1.4285

  //Small
  static const num _smallfontSize = 12.0;
  static num get _smallLineHeight => (16.0 / _smallfontSize); //1.3

  //Sub
  static const num _subfontSize = 10.0;
  static num get _subLineHeight => (16.0 / _subfontSize); //1.6//H0 Text styles.

  //TEXT STYLES
  static TextStyle h0(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_h0fontSize),
        height: context.fontSize(_h0LineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral800,
        letterSpacing: -1,
      );

  //H1 Text styles.
  static TextStyle h1(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_h1fontSize),
        height: context.fontSize(_h1LineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral800,
        letterSpacing: -1,
      );

  //H2 Text styles.
  static TextStyle h2(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_h2fontSize),
        height: context.fontSize(_h2LineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral800,
        letterSpacing: -1,
      );

  //H3 Text styles.
  static TextStyle h3(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_h3fontSize),
        height: context.fontSize(_h3LineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral800,
        letterSpacing: -0.6,
      );

  //H4 Text styles.
  static TextStyle h4(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_h4fontSize),
        height: context.fontSize(_h4LineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral800,
        letterSpacing: 0,
      );

  //Body Text styles.
  static TextStyle body(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_bodyfontSize),
        height: context.fontSize(_bodyLineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral700,
        letterSpacing: 0,
      );

  //Small Text styles.
  static TextStyle small(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_smallfontSize),
        height: context.fontSize(_smallLineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral700,
        letterSpacing: 0,
      );

  //Sub Text styles.
  static TextStyle sub(
    BuildContext context, {
    OttoFontWeight? fontWeight,
    Color? fontColor,
  }) =>
      TextStyle(
        fontSize: context.fontSize(_subfontSize),
        height: context.fontSize(_subLineHeight),
        fontWeight: OttoFont.fontWeight(fontWeight),
        fontFamily: OttoFont.dmSans,
        color: fontColor ?? OttoColor.neutral700,
        letterSpacing: 0,
      );
}
