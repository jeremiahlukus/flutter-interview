import 'package:flutter/material.dart';
import 'package:otto_app/src/components/widgets/k_circular_progress_indicator.dart';
import 'package:otto_app/src/extensions/src/context_extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class KButton extends StatelessWidget {
  final VoidCallback _onPressed;

  final String? _text;
  final bool _isLoading, _isUsedInForm, _isDisabled;
  final Color? _textColor;
  final Color _activeColor;
  final Color _disbaledColor;
  final double _bottomMargin;

  const KButton({
    Key? key,
    required VoidCallback onPressed,
    String? text,
    Color? textColor,
    bool? isLoading,
    bool? isDisabled,
    bool? isUsedInForms,
    Color? activeColor,
    Color? disabledColor,
    double? bottomMargin,
    double? fontSize,
  })  : _onPressed = onPressed,
        _text = text,
        _textColor = textColor,
        _isLoading = isLoading ?? false,
        _isUsedInForm = isUsedInForms ?? false,
        _activeColor = activeColor ?? OttoColor.primaryBlue600,
        _disbaledColor = disabledColor ?? OttoColor.neutral300,
        _bottomMargin = bottomMargin ?? 0.0,
        _isDisabled = isDisabled ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: context.width,
        maxWidth: context.width,
        minHeight: 50,
      ),
      child: Padding(
        padding: context.insetsOnly(bottom: _bottomMargin),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              _isDisabled ? _disbaledColor : _activeColor,
            ),
            elevation: MaterialStateProperty.all<double>(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              context.insetsSymetric(
                vertical: 16,
                horizontal: 24,
              ),
            ),
          ),
          onPressed: _isDisabled
              ? null
              : () {
                  if (_isUsedInForm) {
                    context.unFocus;
                    context.resetFocus;
                  }

                  if (!_isLoading) _onPressed();
                },
          child: _isLoading
              ? const KCircularProgressLoader()
              : Text(
                  _text ?? context.lang.next,
                  style: OttoFont.body(
                    context,
                    fontWeight: OttoFontWeight.medium,
                    fontColor: _textColor ??
                        (_isDisabled ? OttoColor.neutral500 : OttoColor.white),
                  ),
                ),
        ),
      ),
    );
  }
}
