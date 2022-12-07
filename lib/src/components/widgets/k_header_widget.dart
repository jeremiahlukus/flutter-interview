import 'package:flutter/material.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class KHeaderWidget extends StatelessWidget {
  final String? title;
  final String? description;
  const KHeaderWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: OttoFont.h2(
            context,
            fontWeight: OttoFontWeight.bold,
          ),
        ),
        const YMargin(7),
        Text(
          description ?? '',
          style: OttoFont.body(context),
        ),
        const YMargin(25),
      ],
    );
  }
}
