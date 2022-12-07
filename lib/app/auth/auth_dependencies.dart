import 'package:otto_app/app/auth/data/data_sources/auth_data_source.dart';
import 'package:otto_app/app/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:otto_app/app/auth/data/repo_impls/auth_repo_impl.dart';
import 'package:otto_app/app/auth/domain/repos/auth_repo.dart';
import 'package:otto_app/app/auth/domain/use_cases/login_register.dart';
import 'package:otto_app/app/auth/domain/use_cases/verify_auth_otp.dart';
import 'package:otto_app/app/auth/presentation/logic/view_models/login_register_view_model.dart';
import 'package:otto_app/app/auth/presentation/logic/view_models/verify_otp_view_model.dart';
import 'package:otto_flutter_core/config/DI/di.dart';

void registerAuthDI() {
  ///[Datasource].
  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(locator()),
  );

  ///[Repository].
  locator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(locator()),
  );

  ///[Use cases].
  locator.registerLazySingleton(() => LoginOrRegister(locator()));
  locator.registerLazySingleton(() => VerifyAuthOTP(locator()));

  ///[View model].
  locator.registerLazySingleton(() => LoginRegsiterViewModel(locator()));
  locator.registerLazySingleton(
    () => VerifyOTPViewModel(locator()),
  );
}
