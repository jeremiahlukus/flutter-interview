import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:otto_app/src/components/forms/helpers/validation_regex.dart';

class ThousandsInputFormatter extends TextInputFormatter {
  final int maxLength;
  final String locale;
  late final NumberFormat _thousandsFormatter;

  ThousandsInputFormatter({this.maxLength = 15, this.locale = 'en'}) {
    _thousandsFormatter =
        NumberFormat.currency(locale: locale, symbol: '', decimalDigits: 0);
  }

  String format(num numValue) {
    return _thousandsFormatter.format(numValue);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) return newValue;

    if (newValue.selection.baseOffset > maxLength) {
      return oldValue;
    }

    double value =
        double.parse(newValue.text.replaceAll(OttoRegex.nonNumberRegExp, ""));
    String newText = _thousandsFormatter.format(value).trim();
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
