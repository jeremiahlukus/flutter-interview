import 'package:flutter/material.dart';
import 'package:otto_app/src/navigation/navigation.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:styled_text/styled_text.dart';

class KStyledText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final Color? fontColor;
  final TextAlign textAlign;
  final Function(String value)? onChanged;

  //Passing a value to the Widget will be used to decide what action to take
  //onTap event.
  final Function(String?)? onTap;

  const KStyledText(
    this.data, {
    Key? key,
    this.style,
    this.fontColor,
    this.textAlign = TextAlign.start,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledText(
      style: style,
      textAlign: textAlign,
      text: data,
      tags: {
        'smallMedium': StyledTextTag(
          style: OttoFont.small(
            context,
            fontWeight: OttoFontWeight.medium,
            fontColor: fontColor ?? OttoColor.primaryBlue500,
          ),
        ),
        'smallRegular': StyledTextTag(
          style: OttoFont.small(context),
        ),
        'bold': StyledTextTag(
          style: OttoFont.body(
            context,
            fontWeight: OttoFontWeight.bold,
            fontColor: fontColor,
          ),
        ),
        'italic': StyledTextTag(
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        'underline': StyledTextTag(
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
        'primaryColor': StyledTextTag(
          style: const TextStyle(
            color: OttoColor.primaryBlue500,
          ),
        ),
        'navigate': StyledTextActionTag(
          (text, attributes) {
            if (attributes.keys.contains('to')) {
              if (attributes.keys.contains('param')) {
                navigate(
                  context,
                  attributes['to']!,
                  data: attributes.keys.contains('param'),
                );
              } else {
                navigate(context, attributes['to']!);
              }
            }
          },
        ),
        'onTap': StyledTextActionTag(
          (text, attributes) => onTap!(text!.trim().toLowerCase()),
        ),
        'onChnaged': StyledTextActionTag(
          (text, attributes) => onChanged!(text!),
        )
      },
    );
  }
}
