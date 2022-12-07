import 'package:otto_app/app/auth/domain/params/post_params.dart';

class TestAuthParams {
  static final loginParams = {
    "phone": "4139656496",
  };

  static final verifyOTPParams = VerifyOTPParams(
    phoneNumber: "+17135626553",
    code: "1234556",
  );
}
