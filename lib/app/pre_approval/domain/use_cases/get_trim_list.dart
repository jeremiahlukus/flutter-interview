import 'package:otto_app/app/pre_approval/domain/params/params.dart';
import 'package:otto_app/app/pre_approval/domain/repo/appraisal_repo.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

///Get Trim List is used to get the trims for given vehicle make, model and year
class GetTrimList with UseCases<ApiResult<List<String>>, TrimListParams> {
  final AppraisalRepo _appraisalRepo;
  GetTrimList(this._appraisalRepo);

  @override
  Future<ApiResult<List<String>>> call(TrimListParams params) =>
      _appraisalRepo.getTrimList(params.make, params.model, params.year);
}
