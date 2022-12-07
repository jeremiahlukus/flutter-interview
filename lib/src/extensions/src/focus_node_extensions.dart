import 'package:flutter/material.dart';
import 'package:otto_app/src/components/forms/helpers/keyboard/keyboard_overlay.dart';

extension FocusNodeExtension on FocusNode {
  get decideDoneAction => addListener(() {
        bool hasFocus = this.hasFocus;
        if (hasFocus) {
          KeyboardOverlay.showOverlay(context!);
        } else {
          KeyboardOverlay.removeOverlay();
        }
      });
}
