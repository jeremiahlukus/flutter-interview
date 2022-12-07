import 'package:otto_app/app/auth/domain/repos/auth_repo.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_flutter_core/service_result/service_result.dart';
import 'package:otto_flutter_core/use_cases/use_cases.dart';

///Send OTP will be used as login and registration mechanics
///
///[Login] when the phone number/params has been used before, then.
///[Register] when the phone number/params has not been used.
class LoginOrRegister with UseCases<ApiResult<SuccessfullResponse>, String> {
  final AuthRepo _authRepo;
  LoginOrRegister(this._authRepo);

  @override
  Future<ApiResult<SuccessfullResponse>> call(String params) =>
      _authRepo.login(params);
}
