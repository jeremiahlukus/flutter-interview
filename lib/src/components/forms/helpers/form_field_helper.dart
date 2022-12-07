import 'package:flutter/material.dart';
import 'package:otto_app/src/components/forms/states/focus_state.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';

class OttoFormFocusHelper {
  final ValueNotifier<FocusState> focusState =
      ValueNotifier(const FocusState());

  Color get floatingLabelColor {
    if (focusState.value.isFocused ?? false) return OttoColor.primaryBlue500;

    if (focusState.value.hasError ?? false) return OttoColor.red500;

    return OttoColor.neutral700;
  }

  Color get borderColor {
    if (focusState.value.isFocused ?? false) return OttoColor.primaryBlue500;

    if (focusState.value.hasError ?? false) return OttoColor.red500;

    return OttoColor.neutral200;
  }

  double get prefixTextPaddingTop {
    if ((!focusState.value.hasValue!) && (focusState.value.hasError ?? false)) {
      return 0.0;
    }

    if (focusState.value.hasValue ?? false) return 16.0;

    if (focusState.value.isFocused ?? false) return 16.0;

    if (focusState.value.hasError ?? false) return 16.0;

    return 0.0;
  }

  reset() {
    focusState.value = const FocusState();
  }
}
