import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/navigation/navigation.dart';
import 'package:otto_app/src/res/assets/svgs/icons.dart';

class KBackButton extends StatelessWidget {
  final Brightness brightness;
  const KBackButton({
    Key? key,
    this.brightness = Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => popView(context),
      padding: context.insetsAll(0),
      icon: SvgPicture.asset(
        brightness == Brightness.light
            ? kSvgIconBackArrowWithBg
            : kSvgIconDarkBackArrowWithBg,
        height: 40,
      ),
    );
  }
}
