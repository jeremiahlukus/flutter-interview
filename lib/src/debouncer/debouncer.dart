import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
      _timer = Timer(Duration(milliseconds: milliseconds), action);
    } else {
      // on the first time on debouncing we runn immediatly
      _timer = Timer(const Duration(milliseconds: 1), action);
    }
  }
}
