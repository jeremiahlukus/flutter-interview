import 'package:otto_app/app/pre_approval/data/data_sources/appraisal_data_souce.dart';
import 'package:otto_app/app/pre_approval/domain/entities/vin_information.dart';
import 'package:otto_app/app/pre_approval/domain/repo/appraisal_repo.dart';
import 'package:otto_app/core/helper/dio_helper.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

class AppraisalRepoImpl extends AppraisalRepo {
  final AppraisalDataSource _remoteDataSource;

  AppraisalRepoImpl(this._remoteDataSource);

  //TODO:Create a service with freezed that returns success or `failure/exception`
  //you can check the `ApiResult` for example.

  //TODO:Create an interceptor/middleware that handles the error,
  //You can check the `dioInterceptor` to see how we did for API stuff.

  //TODO:Definitely you have to Replace `ApiResult with your own service`.
  @override
  Future<ApiResult<List<String>>> getMakeList() {
    // TODO: implement getModelList
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<String>>> getModelList(String make) {
    // TODO: implement getModelList
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<String>>> getYearList(String make, String model) {
    // TODO: implement getModelList
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<String>>> getTrimList(
      String make, String model, String year) {
    // TODO: implement getModelList
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<VinInformation>> getInfoByVin(String vin) {
    return dioInterceptor<VinInformation>(
      () => _remoteDataSource.getInfoByVin(vin),
    );
  }
}
