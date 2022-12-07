///[VerifyOTPParams].
class VerifyOTPParams {
  ///Phone number of user.
  final String? phoneNumber;

  ///[OTP]code sent to the user .
  final String? code;

  VerifyOTPParams({
    this.phoneNumber,
    this.code,
  });

  ///Converts the paramter of this class passed from the presentation layer
  ///to a [map] that will be used in the data layer.
  Map<String, Object> toMap() {
    return {
      "code": code as String,
      "phone": phoneNumber as String,
    };
  }
}
