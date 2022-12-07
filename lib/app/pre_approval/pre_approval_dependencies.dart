import 'package:otto_app/app/pre_approval/data/data_sources/appraisal_data_souce.dart';
import 'package:otto_app/app/pre_approval/data/data_sources/appraisal_data_souce_impl.dart';
import 'package:otto_app/app/pre_approval/data/repo_impl/appraisal_repo_impl.dart';
import 'package:otto_app/app/pre_approval/domain/repo/appraisal_repo.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_make_list.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_model_list.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_trim_list.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_year_list.dart';
import 'package:otto_app/app/pre_approval/presentation/logic/view_models/appraise_by_drilldown_view_model.dart';
import 'package:otto_app/app/pre_approval/presentation/logic/view_models/appraise_by_vin_view_model.dart';
import 'package:otto_app/app/pre_approval/presentation/logic/view_models/user_details_view_model.dart';
import 'package:otto_flutter_core/config/DI/di.dart';

void registerPreApprovalDI() {
  ///[Datasource].
  locator.registerLazySingleton<AppraisalDataSource>(
    () => AppraisalDataSourceImpl(locator()),
  );

  ///[Repository].
  locator.registerLazySingleton<AppraisalRepo>(
    () => AppraisalRepoImpl(locator()),
  );

  ///[Use cases].
  locator.registerLazySingleton(() => GetMakeList(locator()));
  locator.registerLazySingleton(() => GetModelList(locator()));
  locator.registerLazySingleton(() => GetYearList(locator()));
  locator.registerLazySingleton(() => GetTrimList(locator()));

  ///[View model].
  locator.registerLazySingleton(() => UpdateUserDetailsViewModel());

  locator.registerLazySingleton(
    () => AppraiseByDrilldownViewModel(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton(() => AppraiseByVinViewModel(locator()));
}
