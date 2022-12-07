import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:otto_app/app/pre_approval/domain/entities/offer.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/widgets/offer_item.dart';
import 'package:otto_app/src/components/buttons/k_button.dart';
import 'package:otto_app/src/components/toast/k_toast.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/assets/assets.dart';
import 'package:otto_app/src/res/assets/json/jsons.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final appraisal = DBUtils.appraise; */

    return Scaffold(
      backgroundColor: const Color(0XFFF8F8F8),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: context.scaleY(413),
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.passthrough,
                  children: [
                    LottieBuilder.asset(kJSONOfferAnimaytionOne),
                    LottieBuilder.asset(kJSONOfferAnimaytionTwo),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const YMargin(40),
                        Stack(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                kSvgPreApprovalHandIllustrationBackground,
                                width: 125,
                                height: 126,
                              ),
                            ),
                            Center(
                              child: SvgPicture.asset(
                                kSvgPreApprovalHandIllustration,
                                width: 125,
                                height: 126,
                              ),
                            )
                          ],
                        ),
                        const YMargin(26),
                        Center(
                          child: Container(
                            padding: context.insetsAll(4).copyWith(right: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: OttoColor.yellow400,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                              color: OttoColor.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircleAvatar(
                                  child: Text('🚀'),
                                  backgroundColor: Color(0xFFFCF1F1),
                                ),
                                const XMargin(5),

                                //TODO:Get the user firstname from local storage and replace the `firstname` string.
                                Text(
                                  '${context.lang.congratulations} firstname !',
                                  style: OttoFont.small(
                                    context,
                                    fontColor: OttoColor.neutral800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const YMargin(21),
                        Text(
                          context.lang.offerTitleMobile,
                          style: OttoFont.body(
                            context,
                            fontColor: OttoColor.neutral700,
                          ),
                        ),
                        const YMargin(8),
                        //The text widget below is used to display credit limit,
                        //Credit limit is the amount we give to users to spend based on the value and condition of their car.
                        //TODO:Come up with an approach that you can use to dynamically generate credit limit,
                        //PS: Credit limit must not be a static value.
                        Text(
                          '0,0',
                          style: OttoFont.h0(
                            context,
                            fontWeight: OttoFontWeight.bold,
                            fontColor: OttoColor.primaryBlue600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: context.insetsSymetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //TODO:Get the make, model and year value from local storage and popultae the text accordingly.
                    OfferItem(
                      offer: Offer(
                        asset: kSvgPreApprovalVehicle,
                        title: context.lang.vehicle,
                        description: "make model year",
                      ),
                    ),
                    const YMargin(10),
                    OfferItem(
                      offer: Offer(
                        asset: kSvgPreApprovalInterest,
                        title: context.lang.annualInterestRate,
                        description: '24.99%',
                      ),
                    ),
                    const YMargin(10),
                    Text(
                      context.lang.offerDescMobile,
                      style: OttoFont.small(
                        context,
                        fontColor: OttoColor.neutral600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const YMargin(30),
                    KButton(
                      onPressed: () {
                        KToast(
                          context,
                          title: 'Congrats',
                        );
                      },
                      text: context.lang.getYourCredit,
                    ),
                    const YMargin(47),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
