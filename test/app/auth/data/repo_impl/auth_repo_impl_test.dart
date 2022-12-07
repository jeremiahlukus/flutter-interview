import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otto_app/app/auth/data/data_sources/auth_data_source.dart';
import 'package:otto_app/app/auth/data/repo_impls/auth_repo_impl.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';
import 'package:otto_flutter_core/service_result/service_result.dart';

import '../../../../core/helper/dio_test_helper.dart';
import '../../params.dart';

class _MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late _MockAuthDataSource _mockAuthDataSource;
  late AuthRepoImpl _authRepoImpl;

  setUp(() {
    _mockAuthDataSource = _MockAuthDataSource();
    _authRepoImpl = AuthRepoImpl(_mockAuthDataSource);
    registerFallbackValue(TestAuthParams.verifyOTPParams);
  });

  /**
   * SEND OTP TEST
   */
  group('::SEND OTP::', () {
    const _testPhoneNumber = "4139656496";
    test(
      'Return::[ApiResult.success]'
      'with USER object when the call to the server is successful',
      () async {
        SuccessfullResponse<NoData> _testUser =
            SuccessfullResponse.ok(data: NoData());

        when(
          () => _mockAuthDataSource.postSendOTP(any()),
        ).thenAnswer((_) async => _testUser);

        final result = await _authRepoImpl.login(_testPhoneNumber);

        verify(() => _mockAuthDataSource.postSendOTP(any())).called(1);
        expect(result, equals(ApiResult.success(data: _testUser)));
      },
    );

    ///Test possible failure cases.
    group(
      'Return::[ApiResult.apiFailure]',
      () {
        runSeveralErrorCases(
          mockFunction: () => _mockAuthDataSource.postSendOTP(any()),
          realFunction: () => _authRepoImpl.login(_testPhoneNumber),
        );
      },
    );
  });

  /**
   * VERIFY OTP TEST
   */
  //TODO:Write repo implementation unit test for verify OTP success case.
  group('::VERIFY OTP::', () {
    test(
      'Return::[ApiResult.success]'
      'with verify OTP Map when the call to the server is successful',
      () async {},
    );

    ///Test possible failure cases.
    group(
      'Return::[ApiResult.apiFailure]',
      () {
        runSeveralErrorCases(
          mockFunction: () => _mockAuthDataSource.postVerifyOTP(any()),
          realFunction: () => _authRepoImpl.verifyOTP(
            TestAuthParams.verifyOTPParams,
          ),
        );
      },
    );
  });
}
