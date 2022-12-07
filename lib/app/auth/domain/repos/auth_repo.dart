import 'package:otto_app/app/auth/domain/entities/user.dart';
import 'package:otto_app/app/auth/domain/params/post_params.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_flutter_core/service_result/service_result.dart';

abstract class AuthRepo {
  Future<ApiResult<SuccessfullResponse<NoData>>> login(String phoneNumber);

  Future<ApiResult<SuccessfullResponse<User>>> verifyOTP(
    VerifyOTPParams params,
  );
}
