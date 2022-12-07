import 'package:otto_app/app/pre_approval/domain/entities/appraisal.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_info_by_vin.dart';
import 'package:otto_app/core/provider/base_notifier.dart';

const maxVinSize = 17;

class AppraiseByVinViewModel extends BaseNotifier {
  final GetInfoByVin _getInfoByVin;

  AppraiseByVinViewModel(
    this._getInfoByVin,
  );

  String? errorMessage;

  bool validVin = false;
  bool loadingVinInfo = false;
  Appraisal? vehicleInfo;

  Future validateVIN() {
    //TODO:Write a validator to check if the VIN is correct or not.

    //1.Check this link for our VIN Validation https://vpic.nhtsa.dot.gov/api/,
    //Here we use the Decode VIN (Flat format) with our format being JSON.

    //2. Check for the length of the VIN before you hit the GetInfoByVIN use case.

    //3.Note the VIN is only valid if the error code is eual to "0".

    //4.If the error code is not zero then then VIN is not valid,then we should return
    //the vehicle not fund String,

    //If we get and API error, we will let VIN pass and rely on our backend validation

    throw UnimplementedError();
  }

  get resetErrorField {
    errorMessage = null;
  }
}
