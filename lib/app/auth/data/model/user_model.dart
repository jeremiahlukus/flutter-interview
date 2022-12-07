import 'package:otto_app/app/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    String? phone,
    String? email,
    String? firstName,
    String? lastName,
    String? languagePreference,
  }) : super(
          phone: phone,
          email: email,
          firstName: firstName,
          lastName: lastName,
          languagePreference: languagePreference,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phone: json['phone'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      languagePreference: json['languagePreference'],
    );
  }
}
