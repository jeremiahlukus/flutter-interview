import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This Singleton service class is meant to be used ONLY in places where we don't have access to context.
/// Must be initialized in our very first Widget.

class LocalizationService {
  static AppLocalizations? _appLocalization;

  static AppLocalizations? get appLocalization =>
      LocalizationService._appLocalization;

  static void init(BuildContext context) {
    _appLocalization ??= AppLocalizations.of(context);
  }
}
