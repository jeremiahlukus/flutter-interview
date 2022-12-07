import 'package:flutter/material.dart';
import 'package:otto_app/src/extensions/src/context_extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class KBorderButton extends StatelessWidget {
  final VoidCallback _onPressed;

  final String? _text;
  final Color? _textColor, _borderColor;

  const KBorderButton({
    Key? key,
    required VoidCallback onPressed,
    String? text,
    Color? textColor,
    Color? borderColor,
  })  : _onPressed = onPressed,
        _text = text,
        _textColor = textColor ?? OttoColor.black,
        _borderColor = borderColor ?? OttoColor.black,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.width,
        minHeight: 50,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(OttoColor.white),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: _borderColor!,
                width: 1,
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            context.insetsSymetric(
              vertical: 16,
              horizontal: 24,
            ),
          ),
        ),
        onPressed: _onPressed,
        child: Text(
          _text ?? context.lang.next,
          style: OttoFont.body(
            context,
            fontWeight: OttoFontWeight.medium,
            fontColor: _textColor,
          ),
        ),
      ),
    );
  }
}
