import 'package:otto_app/app/pre_approval/domain/entities/vin_information.dart';
import 'package:otto_app/app/pre_approval/domain/repo/appraisal_repo.dart';
import 'package:otto_flutter_core/service_result/src/api_result.dart';
import 'package:otto_flutter_core/use_cases/use_cases.dart';

///Get Info By Vin returns Vehicle information for a given VIN
class GetInfoByVin with UseCases<ApiResult<VinInformation>, String> {
  final AppraisalRepo _appraisalRepo;
  GetInfoByVin(this._appraisalRepo);

  @override
  Future<ApiResult<VinInformation>> call(String params) =>
      _appraisalRepo.getInfoByVin(params);
}
