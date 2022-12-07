import 'package:flutter/material.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class KRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;

  /// The function will receive the radiobutton value
  final Function(T value) onChanged;
  final String? title;
  final String? subtitle;

  final bool _isActive;

  const KRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.subtitle,
  })  : _isActive = value == groupValue,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      splashColor: OttoColor.neutral100,
      child: Padding(
        padding: (title == null && subtitle == null)
            ? EdgeInsets.zero
            : context.insetsSymetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: (title != null || subtitle != null)
              ? MainAxisSize.max
              : MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: 20,
                  height: 20,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: _isActive
                            ? OttoColor.primaryBlue600
                            : OttoColor.neutral300,
                        width: 1,
                      ),
                    ),
                    color: _isActive
                        ? OttoColor.primaryBlue600
                        : Colors.transparent,
                  ),
                ),
                if (_isActive)
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: OttoColor.white,
                    ),
                  ),
              ],
            ),
            (title != null || subtitle != null)
                ? const XMargin(10)
                : const Offstage(),
            (title != null || subtitle != null)
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: OttoFont.body(
                              context,
                              fontWeight: OttoFontWeight.medium,
                              fontColor: OttoColor.neutral800,
                            ),
                          ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: OttoFont.small(
                              context,
                              fontColor: OttoColor.neutral600,
                            ),
                          ),
                      ],
                    ),
                  )
                : const Offstage(),
          ],
        ),
      ),
    );
  }
}
