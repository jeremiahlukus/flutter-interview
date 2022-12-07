import 'package:flutter/material.dart';
import 'package:otto_app/core/helper/error/failure_type.dart';
import 'package:otto_app/src/components/toast/enums.dart';
import 'package:otto_app/src/components/toast/k_toast.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/localization/error_key.dart';
import 'package:otto_flutter_core/service_exceptions/src/api_exceptions.dart';

class ErrorHandler {
  BuildContext context;
  ErrorHandler(this.context);

  //We have this error key set, to display our toast to user,
  //saying "Something went wrong" if the key returned from backend is not in our language file.
  String? _errorKey;

  String errorMessage(
    ApiExceptions exception, {
    required String responseCode,
    required int statusCode,
  }) {
    String errorMessage = '';

    exception.maybeWhen(
      defaultError: () {
        switch (responseCode) {
          //General
          case ErrorKey.inactiveMockError:
            errorMessage = context.lang.inactiveMockError;
            break;
          case ErrorKey.mockNotFoundError:
            errorMessage = context.lang.mockNotFoundError;
            break;

          //AUTH-API
          case ErrorKey.invalidPhoneNumber:
            errorMessage = context.lang.invalidPhoneNumber;
            break;
          case ErrorKey.invalidPhoneLandline:
            errorMessage = context.lang.invalidPhoneLandline;
            break;

          case ErrorKey.invalidOTP:
            errorMessage = context.lang.invalidOTP;
            break;
          case ErrorKey.maxAttemptsOTP:
            errorMessage = context.lang.maxAttemptsOTP;
            break;
          case ErrorKey.expiredOTP:
            errorMessage = context.lang.expiredOTP;
            break;

          //USER-API
          case ErrorKey.invalidBodyPhone:
            errorMessage = context.lang.invalidBodyPhone;
            break;
          case ErrorKey.userNotFound:
            errorMessage = context.lang.userNotFound;
            break;
          case ErrorKey.agreementNotFound:
            errorMessage = context.lang.agreementNotFound;
            break;
          case ErrorKey.addressNotFound:
            errorMessage = context.lang.addressNotFound;
            break;
          case ErrorKey.invalidAddressBody:
            errorMessage = context.lang.invalidAddressBody;
            break;
          case ErrorKey.invalidAgreementType:
            errorMessage = context.lang.invalidAgreementType;
            break;
          case ErrorKey.applicationNotFound:
            errorMessage = context.lang.applicationNotFound;
            break;
          case ErrorKey.invalidApplicationBody:
            errorMessage = context.lang.invalidApplicationBody;
            break;

          //APPRAISAL-API
          case ErrorKey.invalidMake:
            errorMessage = context.lang.invalidMake;
            break;
          case ErrorKey.invalidModel:
            errorMessage = context.lang.invalidModel;
            break;
          case ErrorKey.invalidYear:
            errorMessage = context.lang.invalidYear;
            break;
          case ErrorKey.invalidTrim:
            errorMessage = context.lang.invalidTrim;
            break;
          case ErrorKey.invalidVin:
            errorMessage = context.lang.invalidVin;
            break;
          case ErrorKey.invalidVinNonUs:
            errorMessage = context.lang.invalidVinNonUs;
            break;
          case ErrorKey.invalidUvc:
            errorMessage = context.lang.invalidUvc;
            break;
          case ErrorKey.invalidUvcNonUs:
            errorMessage = context.lang.invalidUvcNonUs;
            break;

          default:
            errorMessage = context.lang.noKey;
            _errorKey = context.lang.noKey;
            break;
        }
      },
      notFound: () {
        errorMessage = context.lang.notFound;
      },
      connectionTimeout: () {
        errorMessage = context.lang.connectionTimeout;
      },
      receiveTimeout: () {
        errorMessage = context.lang.receiveTimeout;
      },
      sendTimeout: () {
        errorMessage = context.lang.receiveTimeout;
      },
      requestTimeout: () {
        errorMessage = context.lang.requestTimeout;
      },
      cancelRequest: () {
        errorMessage = context.lang.cancelRequest;
      },
      noInternetConnection: () {
        errorMessage = context.lang.noInternetConnection;
      },
      unauthorizedRequest: () {
        errorMessage = context.lang.unauthorizedRequest;
      },
      internalServerError: () {
        errorMessage = context.lang.internalServerError;
      },
      serviceUnavailable: () {
        errorMessage = context.lang.serviceUnavailable;
      },
      formatException: () {
        errorMessage = context.lang.formatException;
      },
      unableToProcess: () {
        errorMessage = context.lang.unableToProcess;
      },
      unexpectedError: () {
        errorMessage = context.lang.unexpectedError;
      },
      orElse: () {
        errorMessage = context.lang.noKey;
        _errorKey = context.lang.noKey;
        return _errorKey;
      },
    );

    return errorMessage;
  }

  //[computeError] should display a snack bar,
  //or invoke a call back function that returns the errorMessage.
  computeError(
    ApiExceptions exceptions, {
    required String responseCode,
    required int statusCode,
    Function(String)? callBack,
  }) {
    final errorText = errorMessage(
      exceptions,
      responseCode: responseCode,
      statusCode: statusCode,
    );
    _failureTypeChecker(exceptions, callBack, _errorKey).when(
      fMessage: () {
        callBack!(errorText);
      },
      fWidget: () {
        KToast(
          context,
          title: errorText,
          toastType: ToastType.error,
        );
      },
    );
  }

  //return a failure message type id.
  FailureType _failureTypeChecker(
    ApiExceptions exception,
    Function(String)? callBack,
    String? errorKey,
  ) {
    if (errorKey != null) {
      return const FailureType.fWidget();
    }

    if (exception.runtimeType.toString() == "_\$DefaultError" &&
        callBack != null) {
      return const FailureType.fMessage();
    } else {
      return const FailureType.fWidget();
    }
  }
}
