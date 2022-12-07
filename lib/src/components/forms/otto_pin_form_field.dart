import 'package:flutter/material.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class KOTPFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String) onCompleted;
  final bool? autoFocus;
  final String? errorText;

  const KOTPFormField({
    Key? key,
    required this.controller,
    required this.onCompleted,
    this.onChanged,
    this.autoFocus = false,
    this.errorText,
  }) : super(key: key);

  @override
  State<KOTPFormField> createState() => _KOTPFormFieldState();
}

class _KOTPFormFieldState extends State<KOTPFormField> {
  late FocusNode _inputFocus;

  @override
  void initState() {
    super.initState();
    _inputFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.lang.enterPIN,
          style: OttoFont.sub(context),
        ),
        const YMargin(3),
        PinCodeTextField(
          focusNode: _inputFocus,
          controller: widget.controller,
          autofocus: widget.autoFocus!,
          pinBoxRadius: 10,
          pinBoxHeight: 48,
          pinBoxWidth: 48,
          maxLength: 6,
          pinBoxBorderWidth: 1,
          defaultBorderColor: OttoColor.neutral200,
          hasTextBorderColor: OttoColor.neutral200,
          highlightAnimation: true,
          highlightAnimationBeginColor: OttoColor.primaryBlue600,
          highlightAnimationEndColor: OttoColor.neutral200,
          hasError: (!_inputFocus.hasFocus && (widget.errorText != null)),
          pinTextStyle: OttoFont.h4(
            context,
            fontColor: OttoColor.black,
          ),
          errorBorderColor: OttoColor.red500,
          wrapAlignment: WrapAlignment.spaceAround,
          onTextChanged: widget.onChanged,
          onDone: (val) {
            context.resetFocus;
            widget.onCompleted(val);
          },
        ),
        if (!_inputFocus.hasFocus) const YMargin(4),
        if (!_inputFocus.hasFocus)
          Text(
            widget.errorText ?? '',
            style: OttoFont.sub(
              context,
              fontColor: OttoColor.red500,
            ),
          ),
      ],
    );
  }
}
