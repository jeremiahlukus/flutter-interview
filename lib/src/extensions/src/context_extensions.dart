import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension FocusExtension on BuildContext {
  get resetFocus => FocusScope.of(this).requestFocus(FocusNode());

  get hasFocus => FocusScope.of(this).hasFocus;

  get unFocus => FocusScope.of(this).unfocus();

  requestFocus({
    required FocusNode currentFocus,
    required FocusNode nextFocus,
  }) {
    currentFocus.unfocus();
    return FocusScope.of(this).requestFocus(nextFocus);
  }
}

extension LocalExtension on BuildContext {
  AppLocalizations get lang => AppLocalizations.of(this)!;
}
