import 'dart:developer';

import 'package:flutter/foundation.dart';

// ignore: avoid_classes_with_only_static_members
class OttoLogger {
  static DateTime get _now => DateTime.now();

  static void info(dynamic data) {
    if (kDebugMode) {
      log(
        'MESSAGE -> $data',
        time: _now,
        name: 'OTTO::INFO::LOGGER',
      );
    }
  }

  static void error(dynamic message, {StackTrace? stackTrace, Object? error}) {
    log(
      'ERROR -> $message',
      time: _now,
      stackTrace: stackTrace,
      error: error,
      name: 'OTTO::ERROR::LOGGER',
    );
  }
}
