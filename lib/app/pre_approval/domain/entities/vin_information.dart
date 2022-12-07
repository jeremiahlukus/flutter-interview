import 'package:equatable/equatable.dart';

class VinInformation extends Equatable {
  final String? errorCode;
  final String? errorText;
  final String? make;
  final String? manufacturer;
  final String? model;
  final String? year;

  const VinInformation({
    this.errorCode,
    this.errorText,
    this.make,
    this.manufacturer,
    this.model,
    this.year,
  });

  @override
  List<Object?> get props =>
      [errorCode, errorText, make, manufacturer, model, year];
}
