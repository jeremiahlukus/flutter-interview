import 'package:flutter/material.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class CustomCheckBox extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? value;
  final bool? isChecked;

  /// The function will receive the current checkbox state, a bool checked or not and it's value
  final Function(bool checked, String? value)? onChange;
  final ValueNotifier<bool> _isCheckedListener;

  CustomCheckBox({
    Key? key,
    this.title,
    this.subtitle,
    this.value,
    this.isChecked,
    this.onChange,
  })  : _isCheckedListener = ValueNotifier(isChecked ?? false),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: OttoColor.neutral100,
        onTap: () {
          if (onChange != null) {
            onChange!(!_isCheckedListener.value, value);
          }
          _isCheckedListener.value = !_isCheckedListener.value;
        },
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
              ValueListenableBuilder<bool>(
                valueListenable: _isCheckedListener,
                builder: (BuildContext context, bool _isChecked, _) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastLinearToSlowEaseIn,
                    decoration: BoxDecoration(
                      color: _isChecked
                          ? OttoColor.primaryBlue600
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _isChecked
                            ? OttoColor.primaryBlue600
                            : OttoColor.neutral300,
                        width: 1,
                      ),
                    ),
                    width: 20,
                    height: 20,
                    child: _isChecked
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: OttoColor.white,
                              size: 14.5,
                            ),
                          )
                        : const Offstage(),
                  );
                },
              ),
              (title != null || subtitle != null)
                  ? const XMargin(10)
                  : const Offstage(),
              (title != null || subtitle != null)
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              style: OttoFont.body(
                                context,
                                fontColor: OttoColor.neutral900,
                              ),
                            ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: OttoFont.small(
                                context,
                                fontColor: OttoColor.neutral700,
                              ),
                            ),
                        ],
                      ),
                    )
                  : const Offstage(),
            ],
          ),
        ),
      ),
    );
  }
}
