import 'package:flutter/foundation.dart';

T? stringToEnum<T>(String? str, Iterable<T> values) {
  try {
    return values.firstWhere(
      (value) => describeEnum(value!) == str,
    );
  } on Error {
    return null;
  }
}
