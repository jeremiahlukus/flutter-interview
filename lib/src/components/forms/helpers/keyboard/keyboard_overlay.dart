import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:otto_app/src/components/forms/helpers/keyboard/numeric_done_widget.dart';

class KeyboardOverlay {
  static OverlayEntry? _overlayEntry;

  static showOverlay(BuildContext context) {
    if (_overlayEntry != null || Platform.isAndroid) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0.0,
        left: 0.0,
        child: const NumericDoneWidget(),
      );
    });

    overlayState!.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (Platform.isAndroid) return;

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
