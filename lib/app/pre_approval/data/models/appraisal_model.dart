import 'package:otto_app/app/pre_approval/domain/entities/appraisal.dart';
import 'package:otto_app/core/helper/enum_helper.dart';

// ignore: must_be_immutable
class AppraisalModel extends Appraisal {
  AppraisalModel({
    id,
    vin,
    uvc,
    make,
    model,
    year,
    trim,
    mileage,
    condition,
    payments,
    appraisalValue,
  }) : super(
          vin: vin,
          make: make,
          model: model,
          year: year,
          trim: trim,
          mileage: mileage,
          condition: condition,
          appraisalValue: appraisalValue,
        );

  factory AppraisalModel.fromJson(Map<String, dynamic> json) {
    return AppraisalModel(
      id: json['id']?.toString(),
      vin: json['vin']?.toString(),
      uvc: json['uvc']?.toString(),
      make: json['make']?.toString(),
      model: json['model']?.toString(),
      year: json['year'] as int?,
      trim: json['trim']?.toString(),
      mileage: json['mileage'] as int?,
      condition: stringToEnum<VehicleCondition>(
        json['condition'],
        VehicleCondition.values,
      ),
      payments: stringToEnum<VehicleInPayment>(
        json['payments'],
        VehicleInPayment.values,
      ),
      appraisalValue: (json['appraisalValue'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'vin': vin,
      'make': make,
      'model': model,
      'year': year,
      'trim': trim,
      'mileage': mileage,
      'appraisalValue': appraisalValue,
      'condition': condition
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
