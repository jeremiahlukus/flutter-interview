import 'package:flutter/material.dart';
import 'package:otto_app/src/components/app_bar/otto_app_bar.dart';
import 'package:otto_app/src/components/app_bar/progress_indicator_model.dart';
import 'package:otto_app/src/components/widgets/k_back_button.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/scaler/scaler.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OttoAppBarWithProgress extends OttoAppBar {
  final ProgressModel progressModel;
  final bool? hasBackButton;
  final Brightness brightness;

  const OttoAppBarWithProgress(
      {Key? key,
      required this.progressModel,
      this.hasBackButton = true,
      this.brightness = Brightness.light})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent() {
      if (progressModel.currentPage <= progressModel.totalPage) {
        final pageFraction =
            (progressModel.currentPage / progressModel.totalPage);
        return pageFraction;
      }
      return 0.0;
    }

    return Row(
      children: [
        Padding(
          padding: context.insetsOnly(
            left: 16,
            top: 9,
            bottom: 9,
          ),
          child: KBackButton(brightness: brightness),
        ),
        Expanded(
          child: Padding(
            padding: context.insetsOnly(
              left: 18.0,
              right: (progressModel.currentPage == progressModel.totalPage)
                  ? 14.5
                  : 20.0,
            ),
            child: LinearPercentIndicator(
              lineHeight: 4.0,
              percent: percent(),
              barRadius: const Radius.circular(10.0),
              padding: context.insetsAll(0),
              progressColor: OttoColor.primaryBlue600,
              backgroundColor: brightness == Brightness.light
                  ? OttoColor.neutral100
                  : OttoColor.neutral700,
            ),
          ),
        ),
        if (progressModel.currentPage == progressModel.totalPage)
          Padding(
            padding: context.insetsOnly(
              right: 20.5,
            ),
            child: const Icon(
              Icons.check,
              size: 10,
              color: OttoColor.primaryBlue500,
            ),
          )
      ],
    );
  }
}
