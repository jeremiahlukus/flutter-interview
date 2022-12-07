import 'package:otto_app/app/pre_approval/domain/repo/appraisal_repo.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

///Get Make List is used to get the cars makes for all vehicles
class GetMakeList with UseCases<ApiResult<List<String>>, NoParams> {
  final AppraisalRepo _appraisalRepo;
  GetMakeList(this._appraisalRepo);

  @override
  Future<ApiResult<List<String>>> call(NoParams params) =>
      _appraisalRepo.getMakeList();
}
