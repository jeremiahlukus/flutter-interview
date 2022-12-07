import 'package:flutter/cupertino.dart';
import 'package:otto_app/src/extensions/extensions.dart';

class NumericDoneWidget extends StatelessWidget {
  const NumericDoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CupertinoColors.extraLightBackgroundGray,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: context.insetsOnly(top: 4.0, bottom: 4.0),
          child: CupertinoButton(
            padding: context.insetsOnly(right: 24.0, top: 8.0, bottom: 8.0),
            onPressed: () {
              context.unFocus;
              context.resetFocus;
            },
            child: Text(
              context.lang.done,
              style: const TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
