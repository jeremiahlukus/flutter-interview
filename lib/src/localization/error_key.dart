class ErrorKey {
  static const String defaultCode = 'defaultCode';

  ///API-GENERAL
  static const String inactiveMockError = 'inactiveMockError';
  static const String mockNotFoundError = 'mockNotFoundError';

  ///AUTH-API
  static const String invalidPhoneNumber = 'invalidPhoneNumber';
  static const String invalidPhoneLandline = 'invalidPhoneLandline';

  static const String invalidOTP = 'invalidOTP';
  static const String maxAttemptsOTP = 'maxAttemptsOTP';
  static const String expiredOTP = 'expiredOTP';

  ///USER-API
  static const String invalidBodyPhone = 'invalidBodyPhone';
  static const String userNotFound = 'userNotFound';
  static const String agreementNotFound = 'agreementNotFound';

  static const String addressNotFound = 'addressNotFound';
  static const String invalidAddressBody = 'invalidAddressBody';
  static const String invalidAgreementType = 'invalidAgreementType';
  static const String applicationNotFound = 'applicationNotFound';
  static const String invalidApplicationBody = 'invalidApplicationBody';

  //APPRAISAL-API
  static const String invalidMake = 'invalidMake';
  static const String invalidModel = 'invalidModel';
  static const String invalidYear = 'invalidYear';
  static const String invalidTrim = 'invalidTrim';
  static const String invalidVin = 'invalidVin';
  static const String invalidVinNonUs = 'invalidVinNonUs';
  static const String invalidUvc = 'invalidUvc';
  static const String invalidUvcNonUs = 'invalidUvcNonUs';
  static const String invalidState = 'invalidState';
}
