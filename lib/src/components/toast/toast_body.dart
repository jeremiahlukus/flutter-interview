import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otto_app/src/components/toast/enums.dart';
import 'package:otto_app/src/components/toast/toast_helper.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class ToastBody extends StatelessWidget {
  final String title;
  final String? description;
  final ToastType? toastType;
  const ToastBody({
    Key? key,
    required this.title,
    this.description,
    this.toastType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: context.insetsSymetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        color: ToastHelper.toastBackgroundColor(toastType),
        child: Row(
          children: [
            UnconstrainedBox(
              child: SvgPicture.asset(
                ToastHelper.toastAsset(toastType),
              ),
            ),
            const XMargin(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: OttoFont.body(
                      context,
                      fontWeight: description == null
                          ? OttoFontWeight.medium
                          : OttoFontWeight.bold,
                      fontColor: ToastHelper.toastTextColor(toastType),
                    ),
                  ),
                  if (description != null) const YMargin(4),
                  if (description != null)
                    Text(
                      description!,
                      style: OttoFont.body(
                        context,
                        fontWeight: OttoFontWeight.regular,
                        fontColor: ToastHelper.toastTextColor(toastType),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
