import 'package:flutter/material.dart';
import 'package:otto_app/app/auth/domain/use_cases/login_register.dart';
import 'package:otto_app/core/helper/error/error_handler.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_app/core/provider/base_notifier.dart';
import 'package:otto_app/src/extensions/src/string_extensions.dart';
import 'package:otto_app/src/navigation/navigation.dart';
import 'package:otto_app/src/routes/routes.dart';

class LoginRegsiterViewModel extends BaseNotifier {
  final LoginOrRegister _loginOrRegister;
  LoginRegsiterViewModel(this._loginOrRegister);

  String? phoneNumberFieldError;

  Future loginWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    busy = true;

    final result = await _loginOrRegister
        .call(phoneNumber.formattedPhoneNumber)
        .whenComplete(() => busy = false);

    result.when(
      success: (SuccessfullResponse data) {
        data.whenOrNull(
          ok: (_) => navigate(context, OttoRoutes.verifyOTP, data: phoneNumber),
        );
      },
      apiFailure: (error, statusCode, responseCode) {
        ErrorHandler(context).computeError(
          error,
          responseCode: responseCode,
          statusCode: statusCode,
          callBack: (errorMessage) {
            phoneNumberFieldError = errorMessage;
          },
        );
      },
    );
  }

  get resetErrorField {
    phoneNumberFieldError = null;
  }
}
