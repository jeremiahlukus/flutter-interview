import 'package:otto_app/app/pre_approval/data/models/vin_information_model.dart';
import 'package:otto_flutter_core/otto_flutter_core.dart';

import 'appraisal_data_souce.dart';

const vinValidationUrl =
    'https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvalues/';
const jsonFormatQueryParam = {'format': 'json'};

class AppraisalDataSourceImpl extends AppraisalDataSource {
  final OttoApiClient _apiClient;
  AppraisalDataSourceImpl(this._apiClient);

  //TODO: Create a JSON reader service and use that to return expected [Make, Model, Trim & Year] list below.
  //The json file to be used is located in the root assets folder `jsons/vehicles-interview.json`.
  //PS: This file shouldn't be modified.

  @override
  Future<List<String>> getMakeList() async {
    // TODO: implement getMakeList
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getModelList(String make) {
    // TODO: implement getModelList
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getTrimList(String make, String model, String year) {
    // TODO: implement getTrimList
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getYearList(String make, String model) {
    // TODO: implement getYearList
    throw UnimplementedError();
  }

  @override
  Future<VinInformationModel> getInfoByVin(String vin) async {
    final response = await _apiClient.get(
      "$vinValidationUrl$vin",
      queryParameters: jsonFormatQueryParam,
    );
    List jsonList = response.data["Results"] as List;
    return VinInformationModel.fromJson(jsonList.first);
  }
}
