import 'package:otto_app/src/components/forms/helpers/validation_regex.dart';

extension StringExtension on String {
  String get firstLetter {
    return this[0];
  }

  String get formattedPhoneNumber {
    return '+${replaceAll(RegExp(r'[^\w]+'), '')}';
  }

  String get removeSpecialCharacters {
    return replaceAll(RegExp(r'[^\w]+'), '');
  }

  String get formatNonNumber {
    return replaceAll(OttoRegex.nonNumberRegExp, '');
  }

  String get removeCommas {
    return replaceAll(',', '');
  }
}
