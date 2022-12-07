import 'package:otto_app/app/pre_approval/domain/repo/appraisal_repo.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

///Get Model List is used to get the all possible car models for a given make
class GetModelList with UseCases<ApiResult<List<String>>, String> {
  final AppraisalRepo _appraisalRepo;
  GetModelList(this._appraisalRepo);

  @override
  Future<ApiResult<List<String>>> call(String params) =>
      _appraisalRepo.getModelList(params);
}
