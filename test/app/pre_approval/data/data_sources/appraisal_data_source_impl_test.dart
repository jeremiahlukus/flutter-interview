import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otto_app/app/pre_approval/data/data_sources/appraisal_data_souce_impl.dart';
import 'package:otto_app/app/pre_approval/data/models/vin_information_model.dart';

import '../../../../core/mocks.dart';

void main() {
  late MockOttoApiClient mockOttoApiClient;
  late AppraisalDataSourceImpl appraisalDataSourceImpl;

  setUp(() {
    mockOttoApiClient = MockOttoApiClient();
    appraisalDataSourceImpl = AppraisalDataSourceImpl(mockOttoApiClient);
  });

  test(
      'should return 200 - OK when GET on GET DATA BY VIN is called and returns success.',
      () async {
    // arrange
    const _validVin = "4T1B11HK4KU821966";

    const _decodedVinResponse = {
      "ErrorCode": "0",
      "ErrorText":
          "0 - VIN decoded clean. Check Digit (9th position) is correct",
      "Make": "Toyota",
      "Model": "Camry",
      "ModelYear": "2019"
    };
    const _vinInfo = VinInformationModel(
      errorCode: "0",
      errorText: "0 - VIN decoded clean. Check Digit (9th position) is correct",
      make: "Toyota",
      model: "Camry",
      year: "2019",
    );

    final response = Response(
      requestOptions: RequestOptions(
        path: "$vinValidationUrl$_validVin",
        queryParameters: jsonFormatQueryParam,
      ),
      data: {
        "Results": [_decodedVinResponse]
      },
    );

    when(
      () => mockOttoApiClient.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => response);
    // act
    final result = await appraisalDataSourceImpl.getInfoByVin(_validVin);
    // assert
    verify(
      () => mockOttoApiClient.get(
        "$vinValidationUrl$_validVin",
        queryParameters: jsonFormatQueryParam,
      ),
    ).called(1);
    expect(result, _vinInfo);
  });

  group('Vehicle Drilldown tests', () {
    test(
        'should return 200 - OK when GET on GET MAKE LIST is called and returns success.',
        () async {
      // arrange
      const _makeListResponse = ["Honda", "Toyota", "Ford"];

      final response = Response<List<String>>(
        requestOptions: RequestOptions(
          path: '/appraisal/drilldown/makes',
        ),
        data: _makeListResponse,
      );

      when(
        () => mockOttoApiClient.get(
          any(),
        ),
      ).thenAnswer((_) async => response);
      // act
      final result = await appraisalDataSourceImpl.getMakeList();
      // assert
      verify(
        () => mockOttoApiClient.get(
          '/appraisal/drilldown/makes',
        ),
      ).called(1);
      expect(result, _makeListResponse);
    });

    test(
        'should return 200 - OK when GET on GET MODEL LIST is called and returns success.',
        () async {
      // arrange
      const _makeParam = "Honda";
      const _modelListResponse = [
        "Civic",
        "City",
        "Fit",
      ];

      final response = Response<List<String>>(
        requestOptions: RequestOptions(
            path: '/appraisal/drilldown/models',
            queryParameters: {'make': _makeParam}),
        data: _modelListResponse,
      );

      when(
        () => mockOttoApiClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => response);
      // act
      final result = await appraisalDataSourceImpl.getModelList(_makeParam);
      // assert
      verify(
        () => mockOttoApiClient.get(
          '/appraisal/drilldown/models',
          queryParameters: {'make': _makeParam},
        ),
      ).called(1);
      expect(result, _modelListResponse);
    });

    test(
        'should return 200 - OK when GET on GET YEAR LIST is called and returns success.',
        () async {
      // arrange
      const _makeParam = "Honda";
      const _modelParam = "Civic";
      const _yearListResponse = [
        "2016",
        "2017",
        "2018",
      ];

      final response = Response<List<String>>(
        requestOptions: RequestOptions(
            path: '/appraisal/drilldown/years',
            queryParameters: {'make': _makeParam, 'model': _modelParam}),
        data: _yearListResponse,
      );

      when(
        () => mockOttoApiClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => response);
      // act
      final result =
          await appraisalDataSourceImpl.getYearList(_makeParam, _modelParam);
      // assert
      verify(
        () => mockOttoApiClient.get(
          '/appraisal/drilldown/years',
          queryParameters: {'make': _makeParam, 'model': _modelParam},
        ),
      ).called(1);
      expect(result, _yearListResponse);
    });

    test(
        'should return 200 - OK when GET on GET TRIM LIST is called and returns success.',
        () async {
      // arrange
      const _makeParam = "Honda";
      const _modelParam = "Civic";
      const _yearParam = "2016";
      const _trimListResponse = ["TRIM CODE 1", "TRIM CODE 2", "TRIM CODE 3"];

      final response = Response<List<String>>(
        requestOptions: RequestOptions(
          path: '/appraisal/drilldown/trims',
          queryParameters: {
            'make': _makeParam,
            'model': _modelParam,
            'year': _yearParam
          },
        ),
        data: _trimListResponse,
      );

      when(
        () => mockOttoApiClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => response);
      // act
      final result = await appraisalDataSourceImpl.getTrimList(
          _makeParam, _modelParam, _yearParam);
      // assert
      verify(
        () => mockOttoApiClient.get(
          '/appraisal/drilldown/trims',
          queryParameters: {
            'make': _makeParam,
            'model': _modelParam,
            'year': _yearParam
          },
        ),
      ).called(1);
      expect(result, _trimListResponse);
    });
  });
}
