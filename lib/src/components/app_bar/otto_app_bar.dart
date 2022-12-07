import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otto_app/src/components/widgets/k_back_button.dart';
import 'package:otto_app/src/res/assets/svgs/svgs.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class OttoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool hasLogo;
  final List<Widget>? actions;
  final bool implyLeading;
  final Widget? leading;
  final Color? backGroundColor;

  const OttoAppBar({
    Key? key,
    this.title,
    this.hasLogo = false,
    this.actions,
    this.implyLeading = true,
    this.leading,
    this.backGroundColor,
  })  : preferredSize = const Size.fromHeight(50),
        super(key: key);

  @override
  final Size preferredSize;

  Widget _leading(BuildContext context) {
    if (implyLeading) {
      if (leading != null) {
        return Container(
          height: 40,
          padding: context.insetsOnly(left: 16),
          child: leading!,
        );
      }
      return Padding(
        padding: context.insetsOnly(left: 16),
        child: const KBackButton(),
      );
    }
    return const Offstage();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: hasLogo
          ? SvgPicture.asset(
              kSvgLogo,
              height: context.scaleY(15.0),
            )
          : title != null
              ? Text(
                  title!,
                  style: OttoFont.body(context),
                )
              : null,
      centerTitle: true,
      titleSpacing: 0,
      actions: actions,
      backgroundColor: backGroundColor ?? Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      primary: true,
      automaticallyImplyLeading: implyLeading,
      leading: _leading(context),
    );
  }
}
