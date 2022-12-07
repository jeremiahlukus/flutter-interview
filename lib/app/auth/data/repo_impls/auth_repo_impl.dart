import 'package:otto_app/app/auth/data/data_sources/auth_data_source.dart';
import 'package:otto_app/app/auth/domain/entities/user.dart';
import 'package:otto_app/app/auth/domain/params/post_params.dart';
import 'package:otto_app/app/auth/domain/repos/auth_repo.dart';
import 'package:otto_app/core/helper/dio_helper.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_flutter_core/service_result/src/api_result.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;
  AuthRepoImpl(this._authDataSource);

  @override
  Future<ApiResult<SuccessfullResponse<NoData>>> login(String phoneNumber) {
    return dioInterceptor(() => _authDataSource.postSendOTP(phoneNumber));
  }

  @override
  Future<ApiResult<SuccessfullResponse<User>>> verifyOTP(
    VerifyOTPParams params,
  ) {
    return dioInterceptor(() => _authDataSource.postVerifyOTP(params));
  }
}
