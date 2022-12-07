import 'package:otto_app/app/auth/auth_dependencies.dart';
import 'package:otto_app/app/pre_approval/pre_approval_dependencies.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

void setUpLocator(ApiConfig apiConfig) {
  setupDI(apiConfig: apiConfig);

  ///[API service dependencies].
  locator.registerLazySingleton<OttoApiClient>(
    () => OttoApiClient(apiConfig),
  );

  ///All other app depenendcy should be registered below.
  registerAuthDI();
  registerPreApprovalDI();
}
