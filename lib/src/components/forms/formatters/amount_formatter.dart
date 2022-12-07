import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    ///Set a value when the length of text
    ///in the form field is 0
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final formatter = NumberFormat('#,###,###');
      final int number =
          int.parse(newValue.text.replaceAll(formatter.symbols.GROUP_SEP, ''));
      final newString = formatter.format(number);
      return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(offset: newString.length));
    } else {
      return newValue;
    }
  }
}
