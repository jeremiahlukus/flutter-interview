import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure_type.freezed.dart';

@freezed
class FailureType<T> with _$FailureType {
  const factory FailureType.fMessage() = FMessage<T>;
  const factory FailureType.fWidget() = FWidget<T>;
}
