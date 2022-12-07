import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:otto_app/core/config/app/app_config_service.dart';
import 'package:otto_app/src/components/widgets/k_web_wrapper.dart';
import 'package:otto_app/src/localization/localization_service.dart';
import 'package:otto_app/src/res/themes/theme_stye.dart';
import 'package:otto_app/src/routes/routes.dart';
import 'package:otto_app/src/scaler/scaler.dart';

/// The Widget that configures your application.
class Otto extends StatefulWidget {
  const Otto({
    Key? key,
  }) : super(key: key);

  @override
  State<Otto> createState() => _OttoState();
}

class _OttoState extends State<Otto> {
  @override
  void didChangeDependencies() {
    OttoAppConfigService.init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAware(
      config:
          const ScaleConfig(allowFontScaling: true, width: 375, height: 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppLocalizations.of(context)?.appTitle ?? 'Otto',
        theme: OttoThemes.defaultTheme,
        initialRoute: OttoRoutes.launch,
        routes: OttoRoutes.staticRoutes,
        onGenerateRoute: OttoRoutes.dynamicRoutes,
        builder: (context, page) {
          // We must call it here in order to use localized strings without context
          LocalizationService.init(context);

          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child:
                kIsWeb ? KWebWrapper(child: page!) : page ?? const Offstage(),
          );
        },
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
      ),
    );
  }
}
