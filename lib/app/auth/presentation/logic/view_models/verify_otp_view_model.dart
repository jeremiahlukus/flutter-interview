import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otto_app/app/auth/domain/entities/user.dart';
import 'package:otto_app/app/auth/domain/params/post_params.dart';
import 'package:otto_app/app/auth/domain/use_cases/verify_auth_otp.dart';
import 'package:otto_app/core/helper/error/error_handler.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_app/core/provider/base_notifier.dart';
import 'package:otto_app/src/navigation/navigation.dart';
import 'package:otto_app/src/routes/routes.dart';

class VerifyOTPViewModel extends BaseNotifier {
  final VerifyAuthOTP _verifyAuthOTP;

  VerifyOTPViewModel(this._verifyAuthOTP);

  String? errorMessage;

  Future verifyOTP({
    required BuildContext context,
    required VerifyOTPParams params,
  }) async {
    busy = true;
    final result =
        await _verifyAuthOTP.call(params).whenComplete(() => busy = false);

    return result.when(
      success: (SuccessfullResponse<User> response) {
        return response.whenOrNull(
          ok: (User data) async {
            //TODO 2.0: Save user detials returned from OTP verification in local storage.
            //PS:Use any data storage approach that suites you.

            return navigate(context, OttoRoutes.userDetails);
          },
        );
      },
      apiFailure: (error, statusCode, responseCode) {
        return ErrorHandler(context).computeError(
          error,
          responseCode: responseCode,
          statusCode: statusCode,
          callBack: (value) {
            errorMessage = value;
          },
        );
      },
    );
  }

  get restErrorField {
    errorMessage == null;
  }
}
