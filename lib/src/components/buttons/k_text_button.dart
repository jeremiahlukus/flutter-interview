import 'package:flutter/material.dart';
import 'package:otto_app/src/extensions/src/context_extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class KTextButton extends StatelessWidget {
  final VoidCallback _onPressed;

  final String _text;
  final bool _isLoading, _isUsedInForm;

  const KTextButton({
    Key? key,
    required VoidCallback onPressed,
    required String text,
    bool? isLoading,
    bool? isDisabled,
    bool? isUsedInForm,
    double? bottomMargin,
  })  : _onPressed = onPressed,
        _text = text,
        _isLoading = isLoading ?? false,
        _isUsedInForm = isUsedInForm ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: context.width,
        maxWidth: context.width,
        minHeight: 50,
      ),
      child: TextButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            OttoFont.body(
              context,
              fontWeight: OttoFontWeight.medium,
              fontColor: OttoColor.white,
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(OttoColor.black),
          elevation: MaterialStateProperty.all<double>(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            context.insetsSymetric(
              vertical: 2.2,
              horizontal: 8,
            ),
          ),
        ),
        onPressed: () {
          if (_isUsedInForm) {
            context.unFocus;
            context.resetFocus;
          }

          if (!_isLoading) _onPressed();
        },
        child: Text(
          _text,
          style: OttoFont.body(
            context,
            fontWeight: OttoFontWeight.medium,
            fontColor: OttoColor.white,
          ),
        ),
      ),
    );
  }
}
