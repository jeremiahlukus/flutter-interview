import 'package:flutter/material.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';

class KCircularProgressLoader extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const KCircularProgressLoader({
    Key? key,
    this.height = 20,
    this.width = 20,
    this.color = OttoColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
