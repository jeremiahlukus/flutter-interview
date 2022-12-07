import 'package:flutter/foundation.dart';

///[Future].
mixin UseCases<T, Params> {
  Future<T> call(Params params);
}

///[Streams].
mixin StreamUseCases<T, Params> {
  Stream<T> call(Params params);
}

@immutable
class NoParams {
  @override
  bool operator ==(Object other) {
    return other is NoParams;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
