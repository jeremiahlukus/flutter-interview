import 'package:otto_app/app/auth/data/data_sources/auth_data_source.dart';
import 'package:otto_app/app/auth/data/model/user_model.dart';
import 'package:otto_app/app/auth/domain/params/post_params.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final OttoApiClient _apiClient;
  AuthDataSourceImpl(this._apiClient);

  @override
  Future<SuccessfullResponse<NoData>> postSendOTP(String phoneNumber) async {
    await _apiClient.post(
      '/auth/login',
      data: {'phone': phoneNumber},
    );

    return SuccessfullResponse<NoData>.ok(data: NoData());
  }

  @override
  Future<SuccessfullResponse<UserModel>> postVerifyOTP(
      VerifyOTPParams params) async {
    final response = await _apiClient.post(
      '/auth/login/verify',
      data: params.toMap(),
    );

    //TODO 1: Return the appropraite value.
    throw UnimplementedError();
  }
}
