import 'package:flutter/widgets.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';

class KWebWrapper extends StatelessWidget {
  final Widget child;
  const KWebWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OttoColor.neutral100,
      padding: context.insetsSymetric(horizontal: 300, vertical: 600),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          color: OttoColor.white,
          padding: context.insetsAll(32),
          child: child,
        ),
      ),
    );
  }
}
