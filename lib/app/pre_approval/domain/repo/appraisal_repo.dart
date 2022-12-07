import 'package:otto_app/app/pre_approval/domain/entities/vin_information.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

abstract class AppraisalRepo {
  Future<ApiResult<List<String>>> getMakeList();

  Future<ApiResult<List<String>>> getModelList(String make);

  Future<ApiResult<List<String>>> getYearList(String make, String model);

  Future<ApiResult<List<String>>> getTrimList(
    String make,
    String model,
    String year,
  );

  Future<ApiResult<VinInformation>> getInfoByVin(String vin);
}
