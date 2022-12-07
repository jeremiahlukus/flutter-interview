import 'package:otto_app/app/pre_approval/domain/entities/vin_information.dart';

class VinInformationModel extends VinInformation {
  const VinInformationModel({
    String? errorCode,
    String? errorText,
    String? make,
    String? manufacturer,
    String? model,
    String? year,
  }) : super(
          errorCode: errorCode,
          errorText: errorText,
          make: make,
          manufacturer: manufacturer,
          model: model,
          year: year,
        );

  factory VinInformationModel.fromJson(Map<String, dynamic> json) {
    return VinInformationModel(
      errorCode: json['ErrorCode'],
      errorText: json['ErrorText'],
      make: json['Make'],
      manufacturer: json['Manufacturer'],
      model: json['Model'],
      year: json['ModelYear'],
    );
  }
}
