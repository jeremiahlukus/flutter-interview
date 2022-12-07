import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otto_app/src/localization/error_key.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

import '../mocks.dart';

void runSeveralErrorCases<T>({
  required Future<T> Function() mockFunction,
  required Future<ApiResult<T>> Function() realFunction,
}) {
  if (!locator.isRegistered<NetworkConnection>()) {
    locator.registerLazySingleton<NetworkConnection>(
        () => MockNetworkConnection());
  }

  ///Test for status code [400].
  test(
    '-[ApiExceptions.defaultError]::When status code is 400::',
    () async {
      final exception = DioError(
        requestOptions: RequestOptions(path: ''),
        type: DioErrorType.response,
        error: DioErrorType.response,
        response: Response(
          requestOptions: RequestOptions(
            path: '',
            headers: {"x-mock-response-code": 400},
          ),
          statusCode: 400,
          data: {
            "error": {"message": "Error Message"}
          },
        ),
      );

      when(() => mockFunction()).thenThrow(exception);

      final result = await realFunction();

      verify(() => mockFunction()).called(1);
      expect(
        result,
        equals(
          const ApiResult.apiFailure(
            error: ApiExceptions.defaultError(),
            statusCode: 400,
            responseCode: ErrorKey.defaultCode,
          ),
        ),
      );
    },
  );

  ///[Test for status code 401].
  test(
    '-[ApiExceptions.unauthorizedRequest]::When status code is 401::',
    () async {
      final exception = DioError(
        requestOptions: RequestOptions(path: ''),
        type: DioErrorType.response,
        error: DioErrorType.response,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        ),
      );

      when(() => mockFunction()).thenThrow(exception);

      final result = await realFunction();

      verify(() => mockFunction()).called(1);

      expect(
        result,
        equals(
          const ApiResult.apiFailure(
            error: ApiExceptions.unauthorizedRequest(),
          ),
        ),
      );
    },
  );

  ///Test for status for invalid status code.
  test(
    '::When status code is invalid::',
    () async {
      final exception = DioError(
        requestOptions: RequestOptions(path: ''),
        type: DioErrorType.response,
        error: DioErrorType.response,
        response: Response(
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockFunction()).thenThrow(exception);

      final result = await realFunction();

      verify(() => mockFunction()).called(1);

      expect(
        result,
        equals(
          const ApiResult.apiFailure(
            error: ApiExceptions.unHandledStatusCode(),
          ),
        ),
      );
    },
  );

  ///Test for status for invalid status code.
  test(
    '::Connection time out::\n\n',
    () async {
      final exception = DioError(
        requestOptions: RequestOptions(path: ''),
        type: DioErrorType.connectTimeout,
        error: DioErrorType.connectTimeout,
        response: Response(
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockFunction()).thenThrow(exception);

      final result = await realFunction();

      verify(() => mockFunction()).called(1);
      expect(
        result,
        equals(
          const ApiResult.apiFailure(error: ApiExceptions.connectionTimeout()),
        ),
      );
    },
  );
}
