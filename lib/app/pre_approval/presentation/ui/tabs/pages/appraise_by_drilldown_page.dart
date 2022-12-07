import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otto_app/app/pre_approval/presentation/logic/view_models/appraise_by_drilldown_view_model.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/widgets/dropdown_states/dropdown_content.dart';
import 'package:otto_app/core/provider/base_view.dart';
import 'package:otto_app/src/components/buttons/k_button.dart';
import 'package:otto_app/src/components/forms/formatters/thousands_input_formatter.dart';
import 'package:otto_app/src/components/forms/helpers/validator_helper.dart';
import 'package:otto_app/src/components/forms/otto_drop_down_form_field.dart';
import 'package:otto_app/src/components/forms/otto_form_field.dart';
import 'package:otto_app/src/components/modals/bottom_modal.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/navigation/navigation.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class AppraiseByDrilldownPage extends StatefulWidget {
  const AppraiseByDrilldownPage({Key? key}) : super(key: key);

  @override
  _AppraiseByDrilldownPageState createState() =>
      _AppraiseByDrilldownPageState();
}

class _AppraiseByDrilldownPageState extends State<AppraiseByDrilldownPage> {
  final _filledFieldsStateEmitter = ValueNotifier<bool>(false);

  //keys.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Key _mileageKey = UniqueKey();

  //controllers.
  late TextEditingController _makeFieldController;
  late TextEditingController _modelFieldController;
  late TextEditingController _yearFieldController;
  late TextEditingController _trimFieldController;
  late TextEditingController _mileageFieldController;

  //Focus nodes
  final FocusNode _mileageFN = FocusNode();

  @override
  void initState() {
    super.initState();

    _makeFieldController = TextEditingController(text: '')
      ..addListener(_formValidation);
    _modelFieldController = TextEditingController(text: '')
      ..addListener(_formValidation);
    _yearFieldController = TextEditingController(text: '')
      ..addListener(_formValidation);
    _trimFieldController = TextEditingController(text: '')
      ..addListener(_formValidation);
    _mileageFieldController = TextEditingController(text: '')
      ..addListener(_formValidation);

    _mileageFN.decideDoneAction;

    //For pre-filling our form fields.
    //
    //We willinvoke [_formValidation()]
    //To check button disabled state.
    _formValidation();
  }

  @override
  void dispose() {
    _makeFieldController.dispose();
    _modelFieldController.dispose();
    _yearFieldController.dispose();
    _trimFieldController.dispose();
    _mileageFieldController.dispose();
    _filledFieldsStateEmitter.dispose();

    _mileageFN.dispose();
    super.dispose();
  }

  void _formValidation() {
    _filledFieldsStateEmitter.value = _makeFieldController.text != '' &&
        _modelFieldController.text != '' &&
        _yearFieldController.text != '' &&
        _trimFieldController.text != '' &&
        _mileageFieldController.text != '';
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppraiseByDrilldownViewModel>(
      builder: (_, viewModel, __) {
        _makeFieldController.text = viewModel.selectedMake ?? '';
        _modelFieldController.text = viewModel.selectedModel ?? '';
        _yearFieldController.text = viewModel.selectedYear ?? '';
        _trimFieldController.text = viewModel.selectedTrim ?? '';

        return Form(
          key: _formKey,
          child: Column(
            children: [
              KDropDownFormField(
                  controller: _makeFieldController,
                  hintText: context.lang.carBrand,
                  isRequired: true,
                  errorText: viewModel.makeFieldError,
                  onDropDownTapped: () {
                    viewModel.loadMakeList();

                    KBottomModal.draggable(
                      ctx: context,
                      initialChildSize: .9,
                      builder: (_) {
                        return DropdownContent<String,
                            AppraiseByDrilldownViewModel>(
                          title: context.lang.searchForMakes,
                          items: () => viewModel.makesList,
                          retryFn: viewModel.loadMakeList,
                          filterFn: (String make, String search) =>
                              make.toLowerCase().contains(search.toLowerCase()),
                          onSelected: (String make) {
                            viewModel.selectedMake = make;
                            popView(context);
                          },
                        );
                      },
                    );
                  }),
              KDropDownFormField(
                  controller: _modelFieldController,
                  readOnly: (viewModel.selectedMake == null ||
                      viewModel.selectedMake!.isEmpty),
                  hintText: context.lang.carModel,
                  errorText: viewModel.modelFieldError,
                  isRequired: true,
                  onDropDownTapped: () {
                    viewModel.loadModelList();

                    KBottomModal.draggable(
                      ctx: context,
                      initialChildSize: .9,
                      builder: (_) {
                        return DropdownContent<String,
                            AppraiseByDrilldownViewModel>(
                          title: context.lang.searchForModels,
                          items: () => viewModel.modelsList,
                          retryFn: viewModel.loadModelList,
                          filterFn: (String model, String search) => model
                              .toLowerCase()
                              .contains(search.toLowerCase()),
                          onSelected: (String model) {
                            viewModel.selectedModel = model;
                            popView(context);
                          },
                        );
                      },
                    );
                  }),
              KDropDownFormField(
                controller: _yearFieldController,
                readOnly: (viewModel.selectedModel == null ||
                    viewModel.selectedModel!.isEmpty),
                errorText: viewModel.yearFieldError,
                hintText: context.lang.year,
                isRequired: true,
                onDropDownTapped: () {
                  viewModel.loadYearList();

                  KBottomModal.draggable(
                    ctx: context,
                    initialChildSize: .9,
                    builder: (_) {
                      return DropdownContent<String,
                          AppraiseByDrilldownViewModel>(
                        title: context.lang.searchForYears,
                        items: () => viewModel.yearsList,
                        retryFn: viewModel.loadYearList,
                        filterFn: (String year, String search) =>
                            year.toLowerCase().contains(search.toLowerCase()),
                        onSelected: (String year) {
                          viewModel.selectedYear = year;
                          popView(context);
                        },
                      );
                    },
                  );
                },
              ),
              KDropDownFormField(
                  controller: _trimFieldController,
                  readOnly: (viewModel.selectedYear == null ||
                      viewModel.selectedYear!.isEmpty),
                  hintText: context.lang.trim,
                  errorText: viewModel.trimFieldError,
                  isRequired: true,
                  onDropDownTapped: () {
                    viewModel.loadTrimList();

                    KBottomModal.draggable(
                      ctx: context,
                      initialChildSize: .9,
                      builder: (_) {
                        return DropdownContent<String,
                            AppraiseByDrilldownViewModel>(
                          title: context.lang.searchForTrims,
                          items: () => viewModel.trimsList,
                          filterFn: (String trim, String search) =>
                              trim.toLowerCase().contains(search.toLowerCase()),
                          onSelected: (String trim) {
                            viewModel.selectedTrim = trim;
                            popView(context);
                          },
                        );
                      },
                    );
                  }),
              KFormField(
                key: _mileageKey,
                controller: _mileageFieldController,
                focusNode: _mileageFN,
                hintText: context.lang.mileage,
                isRequired: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsInputFormatter(),
                ],
                validator: (value) =>
                    OttoFormValidator.integerValidator(value!),
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: _filledFieldsStateEmitter,
                builder: (_, bool isAllFieldsFilled, __) {
                  return Column(
                    children: [
                      Text(
                        context.lang.vehicleValidationNotice,
                        textAlign: TextAlign.center,
                        style: OttoFont.small(
                          context,
                          fontColor: OttoColor.neutral600,
                        ),
                      ),
                      const YMargin(14),
                      KButton(
                        onPressed: () {
                          //TODO:Save vehicle details in local storage.
                        },
                        isLoading: viewModel.busy,
                        isDisabled: !isAllFieldsFilled,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
