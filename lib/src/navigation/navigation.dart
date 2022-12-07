import 'package:flutter/material.dart';

void popToFirst(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

void popView(BuildContext context, {Object? popResult}) =>
    Navigator.pop(context, popResult);

Future<void> navigateReplace(
  BuildContext context,
  String routeName, {
  Object? data,
}) {
  return Navigator.pushReplacementNamed(
    context,
    routeName,
    arguments: data,
  );
}

Future<void> navigate(
  BuildContext context,
  String routeName, {
  Object? data,
}) {
  return Navigator.pushNamed(
    context,
    routeName,
    arguments: data,
  );
}

Future<void> pushAndRemoveUntil(
  BuildContext context,
  String routeName, {
  Object? data,
}) {
  return Navigator.of(context).pushNamedAndRemoveUntil(
    routeName,
    (route) => false,
    arguments: data,
  );
}
