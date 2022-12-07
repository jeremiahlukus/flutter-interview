import 'package:otto_app/app/pre_approval/domain/params/params.dart';
import 'package:otto_app/app/pre_approval/domain/repo/appraisal_repo.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

///Get Year List is used to get the available years for given Vehicle make and model
class GetYearList with UseCases<ApiResult<List<String>>, YearListParams> {
  final AppraisalRepo _appraisalRepo;
  GetYearList(this._appraisalRepo);

  @override
  Future<ApiResult<List<String>>> call(YearListParams params) =>
      _appraisalRepo.getYearList(params.make, params.model);
}
