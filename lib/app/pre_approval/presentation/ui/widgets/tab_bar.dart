import 'package:flutter/material.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class OttoTabBar extends StatelessWidget {
  /// Our tab headers
  final List<String> tabs;

  final TabController controller;

  const OttoTabBar({
    Key? key,
    required this.tabs,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: context.insetsAll(5),
      decoration: BoxDecoration(
        color: OttoColor.neutral100,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: OttoColor.white,
        ),
        labelColor: OttoColor.neutral700,
        labelStyle: OttoFont.small(
          context,
          fontWeight: OttoFontWeight.medium,
        ),
        unselectedLabelColor: OttoColor.neutral900,
        unselectedLabelStyle: OttoFont.small(
          context,
          fontWeight: OttoFontWeight.regular,
        ),
        tabs: tabs.map((String tabTitle) {
          return Tab(
            text: tabTitle,
          );
        }).toList(),
      ),
    );
  }
}
