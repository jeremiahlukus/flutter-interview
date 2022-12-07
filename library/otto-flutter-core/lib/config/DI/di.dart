import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:otto_flutter_core/config/service/api_config.dart';
import 'package:otto_flutter_core/connectivity/connectivity.dart';

GetIt locator = GetIt.I;

///[DI] means Dependency injection.
void setupDI({
  required ApiConfig apiConfig,
  bool connectivity = true,
  bool sharedPref = true,
}) {
  ///Internet connection dependencies.
  if (connectivity) {
    locator.registerLazySingleton(() => Connectivity());

    locator.registerLazySingleton<NetworkConnection>(
        () => NetworkConnectionImpl(locator()));
  }
}
