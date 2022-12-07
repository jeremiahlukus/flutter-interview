import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otto_app/app/pre_approval/data/data_sources/appraisal_data_souce.dart';
import 'package:otto_app/app/pre_approval/data/models/appraisal_model.dart';
import 'package:otto_app/app/pre_approval/data/models/vin_information_model.dart';
import 'package:otto_app/app/pre_approval/data/repo_impl/appraisal_repo_impl.dart';
import 'package:otto_app/app/pre_approval/domain/entities/vin_information.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

import '../../../../core/helper/dio_test_helper.dart';

class MockAppraisalRemoteDataSource extends Mock
    implements AppraisalDataSource {}

void main() {
  late AppraisalRepoImpl repository;
  late MockAppraisalRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(AppraisalModel());
  });

  setUp(() {
    mockRemoteDataSource = MockAppraisalRemoteDataSource();
    repository = AppraisalRepoImpl(mockRemoteDataSource);
  });

  // DRILLDOWN TESTS
  //TODO:Unit test success and error cases for [Make list].

  //TODO:Unit test success and error cases for [Model list].

  //TODO:Unit test success and error cases for [Year list].

  //TODO:Unit test success and error cases for [Trim list].

  group(
    'Get VIN INFO',
    () {
      const _validVin = "4T1B11HK4KU821966";

      const _vinInfo = VinInformationModel(
        errorCode: "0",
        errorText:
            "0 - VIN decoded clean. Check Digit (9th position) is correct",
        make: "Toyota",
        model: "Camry",
        year: "2019",
      );

      test(
        'Return::[ApiResult.success]'
        'with VinInformationModel object when the GET call to the server is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getInfoByVin(any()))
              .thenAnswer((_) async => _vinInfo);
          // act
          final result = await repository.getInfoByVin(_validVin);
          // assert
          verify(() => mockRemoteDataSource.getInfoByVin(_validVin));
          expect(
            result,
            equals(
              const ApiResult<VinInformation>.success(data: _vinInfo),
            ),
          );
        },
      );

      group(
        'Return::[ApiResult.apiFailure] - Get Vin Info',
        () {
          runSeveralErrorCases(
            mockFunction: () => mockRemoteDataSource.getInfoByVin(any()),
            realFunction: () => repository.getInfoByVin(_validVin),
          );
        },
      );
    },
  );
}
