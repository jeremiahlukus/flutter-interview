import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'successful_response.freezed.dart';

@freezed
class SuccessfullResponse<T> with _$SuccessfullResponse<T> {
  const factory SuccessfullResponse.ok({required T data}) = Ok<T>;
  const factory SuccessfullResponse.created({required T data}) = Created<T>;
  const factory SuccessfullResponse.accepted() = Accepted<T>;
  const factory SuccessfullResponse.noContent() = NoContent<T>;
}

class NoData extends Equatable {
  @override
  List<Object?> get props => [];
}
