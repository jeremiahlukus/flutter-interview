import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otto_app/src/navigation/navigation.dart';
import 'package:otto_app/src/res/assets/assets.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/routes/routes.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(seconds: 2),
      () {
        navigateReplace(context, OttoRoutes.loginOrRegister);
      },
    );
  }

  @override
  void dispose() {
    if (_timer != null && (_timer?.isActive ?? false)) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: OttoColor.primaryBlue700,
        child: Center(
          child: SvgPicture.asset(
            kSvgLightLogo,
            width: 126,
            height: 36.98,
          ),
        ),
      ),
    );
  }
}
