import 'package:otto_app/src/components/forms/helpers/validation_regex.dart';
import 'package:otto_app/src/localization/localization_service.dart';

class OttoFormValidator {
  /// This service must be initialized in our very first widget
  static final _localization = LocalizationService.appLocalization!;

  static String? phoneNumberValidator(String value) {
    //The lenght check equating to 14 is due to
    //other character that will be automatically added.
    if (value.length < 14) return _localization.incompletePhoneNumber;

    return null;
  }

  static String? vinCodeValidator(String value) {
    if (value.isEmpty) return null;

    if (!OttoRegex.vinRegex.hasMatch(value)) {
      return _localization.enterAValidVIN;
    }

    return null;
  }

  static String? isEmpty(String? text) {
    if (text == null || text.isEmpty) return "";

    return null;
  }

  static String? integerValidator(String value) {
    if (value.isEmpty) return _localization.thisFieldIsRequired;

    if (!OttoRegex.integerRegex.hasMatch(value.trim())) {
      return _localization.enterAValidInteger;
    }

    return null;
  }

  static String? firstNameValidator(String value, {String? errorMsg}) {
    if (value.isEmpty) {
      return _localization.firstNameRequired;
    } else if (!OttoRegex.nameRegExp.hasMatch(value)) {
      return errorMsg ?? _localization.enterOnlyAlphabeticalCharacters;
    } else {
      return null;
    }
  }

  static String? lastNameValidator(String value, {String? errorMsg}) {
    final acceptedFirstName = ['A', 'I', 'O', 'U', 'Y'];

    if (value.isEmpty) {
      return _localization.lastNameRequired;
    } else if (value.length == 1 && (!acceptedFirstName.contains(value))) {
      return _localization.invalidLastName;
    } else if (!OttoRegex.nameRegExp.hasMatch(value)) {
      return errorMsg ?? _localization.enterOnlyAlphabeticalCharacters;
    } else {
      return null;
    }
  }

  static String? fullNameValidator(String value, {String? errorMsg}) {
    if (value.isEmpty) {
      return _localization.nameIsRequired;
    } else if (!OttoRegex.nameRegExp.hasMatch(value)) {
      return errorMsg ?? _localization.enterOnlyAlphabeticalCharacters;
    } else {
      return null;
    }
  }

  static String? emailValidator(String value, {String? errorMsg}) {
    if (value.isEmpty) {
      return _localization.emailIsRequired;
    } else if (!OttoRegex.emailRegex.hasMatch(value)) {
      return errorMsg ?? _localization.enterAValidEmail;
    } else {
      return null;
    }
  }

  static String? zipCodeValidator(String value) {
    if (value.length < 5) return _localization.incompleteZipCode;

    return null;
  }

  static String? doubleValidator(String value, {gratterThanZero = false}) {
    if (value.isEmpty) return _localization.thisFieldIsRequired;

    if (!OttoRegex.numericRegex.hasMatch(value.trim())) {
      return _localization.enterAValidNumber;
    }

    if (gratterThanZero) {
      String justNumbers = value.trim().replaceAll(RegExp(r'[,.\s]'), '');
      double parsedValue = double.parse(justNumbers) / 100;
      if (parsedValue <= 0) {
        return _localization.enterABiggerValue;
      }
    }

    return null;
  }
}
