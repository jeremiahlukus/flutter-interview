import 'package:flutter/material.dart';

class OttoAppConfig extends InheritedWidget {
  final String title;
  final Widget widget;

  //Environment variable stuff.
  final String? baseUrl;

  const OttoAppConfig({
    Key? key,
    required this.title,
    required this.widget,
    this.baseUrl,
  }) : super(key: key, child: widget);

  static OttoAppConfig? _ottoAppConfig;

  static OttoAppConfig? get ottoAppConfig => OttoAppConfig._ottoAppConfig;

  static OttoAppConfig? of(BuildContext context) {
    return _ottoAppConfig ??=
        context.dependOnInheritedWidgetOfExactType(aspect: OttoAppConfig);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
