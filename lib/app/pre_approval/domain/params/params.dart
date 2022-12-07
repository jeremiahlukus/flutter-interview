/*  */
import 'package:equatable/equatable.dart';

///[UserDetailsParams]
///Params meter for updating user details.
class UserDetailsParams {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? languagePreference;

  UserDetailsParams({
    this.firstName,
    this.lastName,
    this.email,
    this.languagePreference,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['languagePreference'] = languagePreference;

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

class YearListParams extends Equatable {
  final String make;
  final String model;

  const YearListParams({required this.make, required this.model});

  @override
  List<Object?> get props => [make, model];
}

class TrimListParams extends Equatable {
  final String make;
  final String model;
  final String year;

  const TrimListParams({
    required this.make,
    required this.model,
    required this.year,
  });

  @override
  List<Object?> get props => [make, model, year];
}
