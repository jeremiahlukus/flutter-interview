import 'package:otto_app/app/auth/domain/entities/user.dart';
import 'package:otto_app/app/auth/domain/params/post_params.dart';
import 'package:otto_app/app/auth/domain/repos/auth_repo.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

class VerifyAuthOTP
    with UseCases<ApiResult<SuccessfullResponse<User>>, VerifyOTPParams> {
  final AuthRepo _authRepo;
  VerifyAuthOTP(this._authRepo);

  @override
  Future<ApiResult<SuccessfullResponse<User>>> call(
    VerifyOTPParams params,
  ) {
    return _authRepo.verifyOTP(params);
  }
}
