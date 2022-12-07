import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otto_app/src/extensions/src/context_extensions.dart';
import 'package:otto_app/src/res/assets/assets.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class DropdownError extends StatelessWidget {
  final VoidCallback? retryFunction;
  final String imagePath;
  final String title;
  final String description;

  const DropdownError({
    Key? key,
    this.retryFunction,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          imagePath,
          height: 120,
        ),
        const SizedBox(height: 25),
        Text(
          title,
          style: OttoFont.h3(
            context,
            fontColor: OttoColor.neutral900,
            fontWeight: OttoFontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: OttoFont.body(
            context,
            fontColor: OttoColor.neutral600,
          ),
        ),
        const SizedBox(height: 25),
        if (retryFunction != null)
          GestureDetector(
            onTap: () => retryFunction!(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(kSvgRefreshIcon),
                const SizedBox(width: 8),
                Text(
                  context.lang.retry,
                  style:
                      OttoFont.h4(context, fontColor: OttoColor.primaryBlue500),
                ),
              ],
            ),
          ),
        const Spacer(),
      ],
    );
  }
}
