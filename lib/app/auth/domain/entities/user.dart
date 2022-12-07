import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? phone;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? languagePreference;

  const User({
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.languagePreference,
  });

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        phone,
        firstName,
        lastName,
      ];
}
