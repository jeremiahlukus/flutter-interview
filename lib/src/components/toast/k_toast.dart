import 'package:flutter/material.dart';
import 'package:otto_app/src/components/toast/enums.dart';
import 'package:otto_app/src/components/toast/toast_body.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class KToast {
  final BuildContext context;
  final String title;
  final String? description;
  final ToastType? toastType;

  //Constructor for normal bottom modal that has fixed value/height.
  KToast(
    this.context, {
    required this.title,
    this.description,
    this.toastType,
  }) {
    _showToast(context);
  }

  _showToast(BuildContext context) {
    final toast = showTopSnackBar(
      context,
      ToastBody(
        title: title,
        description: description,
        toastType: toastType,
      ),
      leftPadding: 0.0,
      rightPadding: 0.0,
      additionalTopPadding: 0.0,
    );

    return toast;
  }
}
