import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otto_app/src/res/assets/svgs/icons.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class KLockNotice extends StatelessWidget {
  final String text;
  const KLockNotice({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.insetsAll(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: OttoColor.neutral100,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            kSvgLockClosed,
          ),
          const XMargin(8.0),
          Expanded(
            child: Text(
              text,
              style: OttoFont.small(
                context,
                fontColor: OttoColor.neutral600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
