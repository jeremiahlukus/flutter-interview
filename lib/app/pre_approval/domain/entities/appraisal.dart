import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:otto_app/core/helper/enum_helper.dart';

// ignore: must_be_immutable
class Appraisal extends Equatable {
  String? vin;
  String? make;
  String? model;
  int? year;
  String? trim;
  int? mileage;
  VehicleCondition? condition;

  ///[appraisalValue] is how much the car is worth,
  /// a raw value returned from blacbook.
  double? appraisalValue;

  Appraisal({
    this.vin,
    this.make,
    this.model,
    this.year,
    this.trim,
    this.mileage,
    this.condition,
    this.appraisalValue,
  });

  void setCondition(String? conditionKey) {
    condition =
        stringToEnum<VehicleCondition>(conditionKey, VehicleCondition.values);
  }

  String get getFormattedMileage {
    //We have this try catch block in case [mileage] returns null.
    try {
      return NumberFormat('#,###,###').format(mileage);
    } catch (_) {
      return '';
    }
  }

  @override
  List<Object?> get props => [
        vin,
        make,
        model,
        year,
        trim,
        mileage,
        condition,
        appraisalValue,
      ];
}

enum VehicleInPayment { yes, no }

enum VehicleCondition { good, average, poor }
