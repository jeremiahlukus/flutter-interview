import 'package:otto_app/app/pre_approval/domain/params/params.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_make_list.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_model_list.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_trim_list.dart';
import 'package:otto_app/app/pre_approval/domain/use_cases/get_year_list.dart';
import 'package:otto_app/core/provider/base_notifier.dart';
import 'package:otto_flutter_core/service_exceptions/src/api_exceptions.dart';
import 'package:otto_flutter_core/use_cases/use_cases.dart';

class AppraiseByDrilldownViewModel extends BaseNotifier {
  final GetMakeList _getMakeList;
  final GetModelList _getModelList;
  final GetYearList _getYearList;
  final GetTrimList _getTrimList;

  AppraiseByDrilldownViewModel(
    this._getMakeList,
    this._getModelList,
    this._getYearList,
    this._getTrimList,
  );

  String? _selectedMake;
  String? _selectedModel;
  String? _selectedYear;
  String? _selectedTrim;

  List<String> makesList = [];
  List<String> modelsList = [];
  List<String> yearsList = [];
  List<String> trimsList = [];

  set selectedMake(String? selected) {
    _selectedMake = selected;
    notifyListeners();
  }

  set selectedModel(String? selected) {
    _selectedModel = selected;
    notifyListeners();
  }

  set selectedYear(String? selected) {
    _selectedYear = selected;
    notifyListeners();
  }

  set selectedTrim(String? selected) {
    _selectedTrim = selected;
    notifyListeners();
  }

  String? get selectedMake => _selectedMake;
  String? get selectedModel => _selectedModel;
  String? get selectedYear => _selectedYear;
  String? get selectedTrim => _selectedTrim;

  String? makeFieldError;
  String? modelFieldError;
  String? yearFieldError;
  String? trimFieldError;

  Future loadMakeList() async {
    /// We have to clean the states. If we fill the entire form and then change the first dropdown, as all of them are dependents
    /// the entire form is invalid. So, whenever we select one option on any dropdown we must clean its dependents fields states
    _selectedMake = null;
    _selectedModel = null;
    _selectedYear = null;
    _selectedTrim = null;
    setListState(ListState.loading);
    final result = await _getMakeList.call(NoParams());

    result.when(
      success: (List<String> data) {
        if (data.isEmpty) {
          setListState(ListState.isEmpty);
        } else {
          setListState(ListState.hasData);
          makesList = data;
        }
      },
      apiFailure: (error, statusCode, responseCode) {
        if (error is NoInternetConnection) {
          setListState(ListState.noInternet);
        }
        setListState(ListState.hasError);
      },
    );
  }

  Future loadModelList() async {
    _selectedModel = null;
    _selectedYear = null;
    _selectedTrim = null;
    setListState(ListState.loading);
    final result = await _getModelList.call(_selectedMake!);

    result.when(
      success: (List<String> data) {
        if (data.isEmpty) {
          setListState(ListState.isEmpty);
        } else {
          setListState(ListState.hasData);
          modelsList = data;
        }
      },
      apiFailure: (error, statusCode, responseCode) {
        if (error is NoInternetConnection) {
          setListState(ListState.noInternet);
        }
        setListState(ListState.hasError);
      },
    );
  }

  Future loadYearList() async {
    _selectedYear = null;
    _selectedTrim = null;
    setListState(ListState.loading);
    final result = await _getYearList.call(
      YearListParams(make: _selectedMake!, model: _selectedModel!),
    );

    result.when(
      success: (List<String> data) {
        if (data.isEmpty) {
          setListState(ListState.isEmpty);
        } else {
          setListState(ListState.hasData);
          yearsList = data;
        }
      },
      apiFailure: (error, statusCode, responseCode) {
        if (error is NoInternetConnection) {
          setListState(ListState.noInternet);
        }
        setListState(ListState.hasError);
      },
    );
  }

  Future loadTrimList() async {
    _selectedTrim = null;
    setListState(ListState.loading);
    final result = await _getTrimList.call(
      TrimListParams(
          make: _selectedMake!, model: _selectedModel!, year: _selectedYear!),
    );

    result.when(
      success: (List<String> data) {
        if (data.isEmpty) {
          setListState(ListState.isEmpty);
        } else {
          setListState(ListState.hasData);
          trimsList = data;
        }
      },
      apiFailure: (error, statusCode, responseCode) {
        if (error is NoInternetConnection) {
          setListState(ListState.noInternet);
        }
        setListState(ListState.hasError);
      },
    );
  }

  get resetErrorField {
    makeFieldError = null;
    modelFieldError = null;
    yearFieldError = null;
    trimFieldError = null;
  }
}
