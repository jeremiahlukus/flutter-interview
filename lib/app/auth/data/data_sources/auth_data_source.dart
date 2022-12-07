import 'package:otto_app/app/auth/data/model/user_model.dart';
import 'package:otto_app/app/auth/domain/params/post_params.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';

abstract class AuthDataSource {
  Future<SuccessfullResponse<NoData>> postSendOTP(String phoneNumber);
  Future<SuccessfullResponse<UserModel>> postVerifyOTP(
    VerifyOTPParams params,
  );
}
