import 'dart:ui';

import 'package:otto_app/src/components/toast/enums.dart';
import 'package:otto_app/src/res/assets/svgs/svgs.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';

class ToastHelper {
  static String toastAsset(ToastType? toastType) {
    switch (toastType) {
      case ToastType.error:
        return kSvgToastError;
      case ToastType.success:
        return kSvgToastSuccess;
      case ToastType.warning:
        return kSvgToastWarning;
      default:
        return kSvgToastSuccess;
    }
  }

  static Color toastBackgroundColor(ToastType? toastType) {
    switch (toastType) {
      case ToastType.error:
        return OttoColor.red200;
      case ToastType.success:
        return OttoColor.green200;
      case ToastType.warning:
        return OttoColor.yellow200;
      default:
        return OttoColor.green200;
    }
  }

  static Color toastTextColor(ToastType? toastType) {
    switch (toastType) {
      case ToastType.error:
        return OttoColor.red700;
      case ToastType.success:
        return OttoColor.green700;
      case ToastType.warning:
        return OttoColor.yellow700;
      default:
        return OttoColor.green700;
    }
  }
}
