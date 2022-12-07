import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otto_app/app/pre_approval/domain/entities/offer.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

import '../../../../../src/res/assets/assets.dart';

class OfferItem extends StatelessWidget {
  final Offer offer;

  const OfferItem({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.insetsAll(15.0),
      decoration: BoxDecoration(
        color: OttoColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer.title ?? '',
                style: OttoFont.small(
                  context,
                  fontColor: OttoColor.neutral600,
                ),
              ),
              Text(
                offer.description ?? '',
                style: OttoFont.body(
                  context,
                  fontColor: OttoColor.neutral900,
                ),
              )
            ],
          ),
          SvgPicture.asset(offer.asset ?? kSvgLogo),
        ],
      ),
    );
  }
}
