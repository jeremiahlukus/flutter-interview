import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otto_app/src/navigation/navigation.dart';

class KAlertDialog {
  static void dialog(
    BuildContext context, {
    required String title,
    String? description,
    List<ActionParam> actions = const [],
  }) {
    if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: description != null ? Text(description) : null,
            actions: actions.isEmpty
                ? [
                    CupertinoDialogAction(
                      child: const Text("Ok"),
                      onPressed: () {
                        popToFirst(context);
                      },
                    )
                  ]
                : actions.map(
                    (action) {
                      return CupertinoDialogAction(
                        child: Text(
                          action.action,
                          style: action.style,
                        ),
                        onPressed: () {
                          if (action.onTap != null) {
                            action.onTap!();
                          }
                          popToFirst(context);
                        },
                      );
                    },
                  ).toList(),
          );
        },
      );
    } else {
      List<Widget> _getAndroidActionList() {
        return actions.isEmpty
            ? [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    popToFirst(context);
                  },
                )
              ]
            : actions.map(
                (action) {
                  return TextButton(
                    child: Text(
                      action.action.toUpperCase(),
                      style: action.style,
                    ),
                    onPressed: () {
                      if (action.onTap != null) {
                        action.onTap!();
                      }
                      popToFirst(context);
                    },
                  );
                },
              ).toList();
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: description != null ? Text(description) : null,
            actionsAlignment: actions.length != 2
                ? MainAxisAlignment.end
                : MainAxisAlignment.spaceBetween,
            actions: actions.length > 2
                ? [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: _getAndroidActionList(),
                    )
                  ]
                : _getAndroidActionList(),
          );
        },
      );
    }
  }
}

class ActionParam {
  final String action;
  final Function? onTap;
  final TextStyle? style;

  ActionParam({required this.action, this.onTap, this.style});
}
