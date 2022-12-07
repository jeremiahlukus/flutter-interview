import 'package:flutter/material.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/scaler/src/extensions.dart';
import 'package:shimmer/shimmer.dart';

const modalHeight = 0.9;
const searchAndTitleSkeletonHeight = 120;
const singleItemSkeletonHeight = 65;

class DropdownLoading extends StatelessWidget {
  const DropdownLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int skeletons =
        ((context.height * modalHeight - searchAndTitleSkeletonHeight) /
                singleItemSkeletonHeight)
            .floor();

    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: OttoColor.neutral100,
            highlightColor: OttoColor.neutral300,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    margin: context.insetsOnly(bottom: 20),
                    decoration: const BoxDecoration(
                      color: OttoColor.neutral100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 1; i < skeletons; i++)
            Shimmer.fromColors(
              baseColor: OttoColor.neutral100,
              highlightColor: OttoColor.neutral300,
              child: Padding(
                padding: context.insetsOnly(bottom: 12, top: 12),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      margin: context.insetsOnly(right: 10),
                      decoration: const BoxDecoration(
                        color: OttoColor.neutral100,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            margin: context.insetsOnly(bottom: 10),
                            decoration: BoxDecoration(
                              color: OttoColor.neutral200,
                              border: Border.all(
                                color: OttoColor.neutral200,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.7,
                            child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: OttoColor.neutral200,
                                border: Border.all(
                                  color: OttoColor.neutral200,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
