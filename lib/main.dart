import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otto_app/core/DI/di.dart';
import 'package:otto_app/core/config/app/app_config.dart';
import 'package:otto_app/core/helper/logger/logger.dart';
import 'package:otto_flutter_core/config/config.dart';

import 'otto.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OttoAppConfig appConfig = const OttoAppConfig(
    title: 'OttoCredit',
    widget: Otto(),
    baseUrl: "https://otto-api.free.beeceptor.com/v1",
  );

  ApiConfig _apiConfig = ApiConfig(
    "https://otto-api.free.beeceptor.com/v1",
  );

  setUpLocator(_apiConfig);

  ///Will enable when we need to start tracking from front end.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runZonedGuarded(
      () => runApp(appConfig),
      (Object error, StackTrace stackTrace) {
        OttoLogger.error(error, stackTrace: stackTrace);
      },
    ),
  );
}
