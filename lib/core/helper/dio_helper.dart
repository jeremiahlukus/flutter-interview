import 'package:otto_app/src/localization/error_key.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

Future<ApiResult<T>> dioInterceptor<T>(
  final Future<T> Function() func,
) async {
  final _networkInfo = locator<NetworkConnection>();

  if (!await _networkInfo.isDeviceConnected) {
    return const ApiResult.apiFailure(
      error: ApiExceptions.noInternetConnection(),
    );
  }

  try {
    final result = await func();
    return ApiResult<T>.success(data: result);
  } on DioError catch (exception, stackTrace) {
    if (exception.response != null) {
      if (exception.response?.statusCode == 401 ||
          exception.response?.statusCode == 403) {
        //TODO:Clear all data from local storage.
      }
    }
    return onDioError(exception, stackTrace);
  } catch (exception) {
    //This will take care of unhandled exceptions
    //i.e (Type cast exceptions).
    return ApiResult.apiFailure(
      error: ApiExceptions.getDioException(exception)!,
    );
  }
}

ApiResult<T> onDioError<T>(
  DioError exception,
  StackTrace stackTrace,
) {
  if (exception.response == null || exception.response?.data == null) {
    return ApiResult.apiFailure(
      error: ApiExceptions.getDioException(exception)!,
    );
  }

  final response = exception.response!;
  final resData = response.data;

  String? errorKey;

  final possibleErrorKey = [
    'error.name',
    'error.code',
    'message',
  ];

  if (resData is Map) {
    // Try to find the first key that matches the key in error model
    for (int i = 0; i < possibleErrorKey.length; i++) {
      errorKey = _extractMessage(resData, possibleErrorKey[i]);

      if (errorKey != null) break; // Found our error message: Break loop
    }
  }

  if (resData != null && exception.response!.statusCode == 400) {
    return ApiResult.apiFailure(
      error: const ApiExceptions.defaultError(),
      statusCode: exception.response!.statusCode!,
      responseCode: errorKey ?? ErrorKey.defaultCode,
    );
  }
  return ApiResult.apiFailure(
    error: ApiExceptions.getDioException(exception)!,
    statusCode: exception.response!.statusCode!,
    responseCode: errorKey ?? ErrorKey.defaultCode,
  );
}

String? _extractMessage(Map data, String model) {
  final models = model.split('.');

  Map? extracted = data;
  try {
    for (int i = 0; i < models.length; i++) {
      final element = models[i];
      if (extracted![element] is String) return extracted[element];

      extracted = extracted[element];
    }
  } catch (e) {
    return null;
  }
  return null;
}
