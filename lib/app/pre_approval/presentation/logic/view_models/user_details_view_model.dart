import 'package:flutter/material.dart';
import 'package:otto_app/app/pre_approval/domain/params/params.dart';
import 'package:otto_app/core/provider/base_notifier.dart';

class UpdateUserDetailsViewModel extends BaseNotifier {
  UpdateUserDetailsViewModel();

  String? errorMessage;

  Future updateUserDetails({
    required BuildContext context,
    required UserDetailsParams params,
  }) async {
    //TODO 2.1: Update user details data for this particular user in local storage.
  }
}
