mixin OttoRegex {
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  static final RegExp complexNameRegex =
      RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');

  static final RegExp emailRegex = RegExp(
      r"^[a-z0-9][-a-z0-9.!#$%&'*+-=?^_`{|}~\/]+@([-a-z0-9]+\.)+[a-z]{2,5}$");

  static final RegExp numberRegExp = RegExp(r'\d');

  static final RegExp nonNumberRegExp = RegExp(r'[^\d]');

  static final RegExp alphaNumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

  static final RegExp onlyDigitsRegex = RegExp(r'^[0-9]*$');

  static final RegExp integerRegex = RegExp(r'^[0-9]{1,3}([,\.\s]?[0-9]{3})*$');

  static final RegExp numericRegex =
      RegExp(r'^[0-9]{1,3}([,\.\s]?[0-9]{3})*([,\.\s][0-9]+)?$');

  static final RegExp vinRegex =
      RegExp(r'(?=.*\d|=.*[A-Za-z])(?=.*[A-Za-z])[A-Za-z0-9]{17}');
}
