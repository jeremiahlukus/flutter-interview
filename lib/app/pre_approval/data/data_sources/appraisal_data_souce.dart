import 'package:otto_app/app/pre_approval/data/models/vin_information_model.dart';

abstract class AppraisalDataSource {
  Future<List<String>> getMakeList();
  Future<List<String>> getModelList(String make);
  Future<List<String>> getYearList(String make, String model);
  Future<List<String>> getTrimList(String make, String model, String year);

  Future<VinInformationModel> getInfoByVin(String vin);
}
