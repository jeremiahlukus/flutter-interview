import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/assets/json/jsons.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/routes/routes.dart';

class CalculatingOfferScreen extends StatefulWidget {
  const CalculatingOfferScreen({Key? key}) : super(key: key);

  @override
  State<CalculatingOfferScreen> createState() => _CalculatingOfferScreenState();
}

class _CalculatingOfferScreenState extends State<CalculatingOfferScreen> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
    Future.delayed(const Duration(seconds: 10), () => OttoRoutes.offer);
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load(kJSONCalculationAnimation);
    return await LottieComposition.fromByteData(assetData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.insetsSymetric(horizontal: 55.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<LottieComposition>(
              future: _composition,
              builder: (context, snapshot) {
                var composition = snapshot.data;
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 2),
                  child: composition != null
                      ? Lottie(
                          key: UniqueKey(),
                          composition: composition,
                        )
                      : Text(
                          context.lang.calculating,
                          key: UniqueKey(),
                          style: OttoFont.body(
                            context,
                          ),
                        ),
                );
              },
            ),
            const YMargin(60),
            Text(
              context.lang.calculatingText,
              style: OttoFont.h4(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
