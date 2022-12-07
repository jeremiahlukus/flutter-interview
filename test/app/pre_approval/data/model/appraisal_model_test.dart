import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:otto_app/app/pre_approval/data/models/appraisal_model.dart';
import 'package:otto_app/app/pre_approval/domain/entities/appraisal.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  var tAppraisalModel = AppraisalModel(
    id: 'C14FDB2B-C3AB-4E4B-AE37-1260F76FEE5A',
    vin: '4Y1SL65848Z411439',
    uvc: '2015360043',
    make: 'honda',
    model: 'civic',
    year: 2011,
    trim: 'EX2D Sedan',
    mileage: 123,
    condition: VehicleCondition.good,
    payments: VehicleInPayment.no,
    appraisalValue: 10000.0,
  );

  test('should AppraisalModel be a subtype of Appraisal Entity', () {
    expect(tAppraisalModel, isA<Appraisal>());
  });

  group('fromJson', () {
    test(
      'should return a valid entity when the JSON correct',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('pre-approval/appraisal.json'));
        // act
        final result = AppraisalModel.fromJson(jsonMap);
        // assert
        expect(result, tAppraisalModel);
      },
    );

    test(
        'should return a valid model with a null value if JSON has a value different from enums.',
        () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pre-approval/appraisal_invalid.json'));
      // act
      final result = AppraisalModel.fromJson(jsonMap);
      // assert
      var expected = AppraisalModel(
          id: 'C14FDB2B-C3AB-4E4B-AE37-1260F76FEE5A',
          vin: '4Y1SL65848Z411439',
          make: 'honda',
          model: 'civic',
          year: 2011,
          trim: 'EX2D Sedan',
          appraisalValue: 10000.0);
      expect(result, expected);
    });
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tAppraisalModel.toJson();
        // assert
        final expectedJsonMap = {
          "id": "C14FDB2B-C3AB-4E4B-AE37-1260F76FEE5A",
          "vin": "4Y1SL65848Z411439",
          "uvc": "2015360043",
          "make": "honda",
          "model": "civic",
          "year": 2011,
          "trim": "EX2D Sedan",
          "mileage": 123,
          "condition": "good",
          "payments": "no",
          "appraisalValue": 10000.0
        };
        expect(result, expectedJsonMap);
      },
    );

    test(
      'should return a JSON map containing the non-null data',
      () async {
        // act
        final result = AppraisalModel(vin: '4Y1SL65848Z411439').toJson();
        // assert
        final expectedJsonMap = {
          'vin': '4Y1SL65848Z411439',
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });

  test(
      'should set a correct enum value no setter passing a String as argument.',
      () {
    // arrange
    const conditionKey = 'average';
    // act
    final result = AppraisalModel();
    result.setCondition(conditionKey);

    // assert
    var expected = AppraisalModel(
        condition: VehicleCondition.average, payments: VehicleInPayment.no);

    expect(result, expected);
  });
}
