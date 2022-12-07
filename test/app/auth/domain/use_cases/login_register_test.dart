import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otto_app/app/auth/domain/use_cases/login_register.dart';
import 'package:otto_app/core/helper/success_response/successful_response.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

import '../../mocks.dart';

void main() {
  late LoginOrRegister _loginOrRegister;
  late MockAuthRepo _mockAuthRepo;

  setUp(() {
    _mockAuthRepo = MockAuthRepo();
    _loginOrRegister = LoginOrRegister(_mockAuthRepo);
  });

  /**
   * SEND OTP TEST
   */
  test(
    '::USE CASE::Send OTP',
    () async {
      SuccessfullResponse<NoData> _testUserResponse =
          SuccessfullResponse.ok(data: NoData());

      when(
        () => _mockAuthRepo.login(any()),
      ).thenAnswer((_) async => ApiResult.success(data: _testUserResponse));

      //Invoke the actual use case.
      final actualUsecase = await _loginOrRegister.call('08168678931');

      //Verify then, compare or return types.
      verify(() => _mockAuthRepo.login(any()));
      expect(actualUsecase, ApiResult.success(data: _testUserResponse));
    },
  );
}
