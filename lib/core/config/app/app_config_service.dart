import 'package:flutter/widgets.dart';
import 'package:otto_app/core/config/app/app_config.dart';

/// This Singleton service class is meant to be used ONLY in places where we don't have access to context.
/// Must be initialized in our very first Widget.

class OttoAppConfigService {
  static OttoAppConfig? _ottoAppConfig;

  static OttoAppConfig? get ottoAppConfig =>
      OttoAppConfigService._ottoAppConfig;

  static void init(BuildContext context) {
    _ottoAppConfig ??= OttoAppConfig.of(context);
  }
}
