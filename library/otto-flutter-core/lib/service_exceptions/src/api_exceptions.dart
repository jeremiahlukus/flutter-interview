import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_exceptions.freezed.dart';

@freezed
class ApiExceptions with _$ApiExceptions {
  const factory ApiExceptions.unHandledStatusCode() = UnHandledStatusCode;

  const factory ApiExceptions.defaultError() = DefaultError;
  const factory ApiExceptions.notFound() = NotFound;

  const factory ApiExceptions.connectionTimeout() = ConnectionTimeout;
  const factory ApiExceptions.receiveTimeout() = ReceiveTimeout;
  const factory ApiExceptions.sendTimeout() = SendTimeout;
  const factory ApiExceptions.requestTimeout() = RequestTimeout;

  const factory ApiExceptions.cancelRequest() = CanceledRequest;

  const factory ApiExceptions.noInternetConnection() = NoInternetConnection;

  const factory ApiExceptions.unauthorizedRequest() = UnauthorizedRequest;

  const factory ApiExceptions.internalServerError() = InternalServerError;
  const factory ApiExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory ApiExceptions.formatException() = FormatException;
  const factory ApiExceptions.unableToProcess() = UnableToProcess;
  const factory ApiExceptions.unexpectedError() = UnexpectedError;

  ///[getDioException] will be used on the reposiroty implementation.
  static ApiExceptions? getDioException(error) {
    if (error is Exception) {
      try {
        ApiExceptions? apiException;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.connectTimeout:
              apiException = const ApiExceptions.connectionTimeout();
              break;
            case DioErrorType.receiveTimeout:
              apiException = const ApiExceptions.receiveTimeout();
              break;
            case DioErrorType.sendTimeout:
              apiException = const ApiExceptions.sendTimeout();
              break;
            case DioErrorType.other:
              apiException = const ApiExceptions.noInternetConnection();
              break;

            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 400:
                  apiException = const ApiExceptions.defaultError();
                  break;
                case 401:
                  apiException = const ApiExceptions.unauthorizedRequest();
                  break;
                case 403:
                  apiException = const ApiExceptions.unauthorizedRequest();
                  break;
                case 404:
                  apiException = const ApiExceptions.notFound();
                  break;
                case 408:
                  apiException = const ApiExceptions.requestTimeout();
                  break;
                case 500:
                case 501:
                case 502:
                case 504:
                case 505:
                  apiException = const ApiExceptions.internalServerError();
                  break;
                case 503:
                  apiException = const ApiExceptions.serviceUnavailable();
                  break;
                default:
                  apiException = const ApiExceptions.unHandledStatusCode();
              }
              break;
            case DioErrorType.cancel:
              apiException = const ApiExceptions.cancelRequest();
              break;
          }
        } else if (error is SocketException) {
          apiException = const ApiExceptions.noInternetConnection();
        } else {
          apiException = const ApiExceptions.unexpectedError();
        }
        return apiException;
      } on FormatException {
        // Helper.printError(e.toString());
        return const ApiExceptions.formatException();
      } catch (_) {
        return const ApiExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('Is not a subtype of')) {
        return const ApiExceptions.unableToProcess();
      } else {
        return const ApiExceptions.unexpectedError();
      }
    }
  }

  ///[getErroKey] maps error key to excpetion,
  ///so it can be used for internalization on the app.
  static String getErrorKey(ApiExceptions apiExceptions) {
    var errorKey = '';
    apiExceptions.when(
      unHandledStatusCode: () {
        errorKey = 'unHandledStatusCode';
      },
      defaultError: () {
        errorKey = 'defaultError';
      },
      notFound: () {
        errorKey = 'notFound';
      },
      connectionTimeout: () {
        errorKey = 'connectionTimeout';
      },
      receiveTimeout: () {
        errorKey = 'receiveTimeout';
      },
      sendTimeout: () {
        errorKey = 'sendTimeout';
      },
      requestTimeout: () {
        errorKey = 'requestTimeout';
      },
      cancelRequest: () {
        errorKey = 'cancelRequest';
      },
      noInternetConnection: () {
        errorKey = 'noInternetConnection';
      },
      unauthorizedRequest: () {
        errorKey = 'unauthorisedRequest';
      },
      internalServerError: () {
        errorKey = 'internalServerError';
      },
      serviceUnavailable: () {
        errorKey = 'serviceUnavailable';
      },
      formatException: () {
        errorKey = 'formatException';
      },
      unableToProcess: () {
        errorKey = 'unableToProcess';
      },
      unexpectedError: () {
        errorKey = 'unexpectedError';
      },
    );
    return errorKey;
  }
}
