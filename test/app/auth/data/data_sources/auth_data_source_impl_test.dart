//define required mocs

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otto_app/app/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';

import '../../../../core/mocks.dart';
import '../../params.dart';
import '../../response.dart';

void main() {
  late MockOttoApiClient _mockOttoApiClient;
  late AuthDataSourceImpl _authDataSourceImpl;

  setUp(() {
    _mockOttoApiClient = MockOttoApiClient();
    _authDataSourceImpl = AuthDataSourceImpl(_mockOttoApiClient);
  });

  ///Test for login or register.
  test('Should return 200 - OK when `auth/login` is called', () async {
    //Arrange.
    const phoneNumber = "4139656496";
    const Map<String, Object> _testParams = {"phone": phoneNumber};

    final _testResponse = Response(
      requestOptions: RequestOptions(
        path: '/auth/login',
        data: _testParams,
      ),
      data: testLoginResponse,
    );

    //Mock call.
    when(
      () => _mockOttoApiClient.post(
        '/auth/login',
        data: any(named: 'data'),
      ),
    ).thenAnswer((_) async => _testResponse);

    //act
    final result = await _authDataSourceImpl.postSendOTP(phoneNumber);

    expect(result, SuccessfullResponse<NoData>.ok(data: NoData()));
  });

  /** 
   * Verify OTP.
  */
  test(
      '::VERIFY OTP:: should return 200 - OK when POST/auth/login/verify is called and returns success.',
      () async {
    final _testResponse = Response(
      requestOptions: RequestOptions(
        path: '/auth/login/verify',
        data: TestAuthParams.verifyOTPParams.toMap(),
      ),
      data: testVerifyAuthOTPResponse,
    );

    //Mock call.
    when(
      () => _mockOttoApiClient.post(
        any(),
        data: any(named: 'data'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => _testResponse);

    //act
    final result = await _authDataSourceImpl.postVerifyOTP(
      TestAuthParams.verifyOTPParams,
    );

    //TODO: Write the expect value.
  });
}
