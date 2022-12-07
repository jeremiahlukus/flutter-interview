import '../../fixtures/fixture_reader.dart';

final testLoginResponse =
    decodeFixture('auth/login.json') as Map<String, dynamic>;

final testVerifyAuthOTPResponse =
    decodeFixture('auth/verify_auth_otp.json') as Map<String, dynamic>;
