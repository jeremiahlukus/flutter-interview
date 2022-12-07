import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final int maxLength;
  final int decimalDigits;
  final String locale;
  late final NumberFormat _currencyFormatter;

  CurrencyInputFormatter({
    this.maxLength = 15,
    this.locale = 'en',
    this.decimalDigits = 2,
  }) {
    _currencyFormatter = NumberFormat.currency(
      locale: locale,
      symbol: '',
      decimalDigits: decimalDigits,
    );
  }

  String format(double doubleValue) {
    return _currencyFormatter.format(doubleValue);
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

    double value = double.parse(newValue.text);
    String newText = _currencyFormatter.format(value / 100).trim();

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
