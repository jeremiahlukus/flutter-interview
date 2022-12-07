import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:otto_flutter_core/service_exceptions/src/api_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.apiFailure({
    required ApiExceptions error,
    @Default(-1) int statusCode,
    @Default('defaultCode') String responseCode,
  }) = Failure<T>;
}
