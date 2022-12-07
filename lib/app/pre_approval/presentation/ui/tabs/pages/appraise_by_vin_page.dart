import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otto_app/app/pre_approval/presentation/logic/view_models/appraise_by_vin_view_model.dart';
import 'package:otto_app/core/provider/base_view.dart';
import 'package:otto_app/src/components/buttons/k_button.dart';
import 'package:otto_app/src/components/forms/formatters/thousands_input_formatter.dart';
import 'package:otto_app/src/components/forms/helpers/validator_helper.dart';
import 'package:otto_app/src/components/forms/otto_form_field.dart';
import 'package:otto_app/src/components/widgets/k_circular_progress_indicator.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class AppraiseByVinPage extends StatefulWidget {
  const AppraiseByVinPage({Key? key}) : super(key: key);

  @override
  _AppraiseByVinPageState createState() => _AppraiseByVinPageState();
}

class _AppraiseByVinPageState extends State<AppraiseByVinPage> {
  final _formIsFilledStateEmitter = ValueNotifier<bool>(false);

  //Keys.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Key _vinKey = UniqueKey();
  final Key _mileageKey = UniqueKey();

  //Controllers.
  late TextEditingController _vinFieldController;
  late TextEditingController _mileageFieldController;

  //Focus Nodes.
  final FocusNode _vinFN = FocusNode();
  final FocusNode _mileageFN = FocusNode();

  @override
  void initState() {
    super.initState();

    _vinFieldController = TextEditingController(text: '')
      ..addListener(() {
        _formIsFilledStateEmitter.value = _formFilledStatus();
      });

    _mileageFieldController = TextEditingController(text: '')
      ..addListener(() {
        _formIsFilledStateEmitter.value = _formFilledStatus();
      });

    _mileageFN.decideDoneAction;

    //For pre-filling our form fields.
    //
    //We will set the value of the [_formfilledStatus] to formStateEmitter
    //To check button disabled state.
    _formIsFilledStateEmitter.value = _formFilledStatus();
  }

  bool _formFilledStatus() {
    return _vinFieldController.text.length == maxVinSize &&
        _mileageFieldController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _vinFieldController.dispose();
    _formIsFilledStateEmitter.dispose();

    _mileageFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppraiseByVinViewModel>(
      builder: (_, viewModel, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  KFormField(
                    key: _vinKey,
                    suffixIcon: viewModel.loadingVinInfo
                        ? const KCircularProgressLoader(
                            color: OttoColor.primaryBlue600,
                          )
                        : viewModel.vehicleInfo != null &&
                                _vinFieldController.text.length == maxVinSize
                            ? const Icon(
                                Icons.check,
                                color: OttoColor.green500,
                              )
                            : null,
                    controller: _vinFieldController,
                    focusNode: _vinFN,
                    hintText: context.lang.vinHintText,
                    isRequired: true,
                    autoFocus: true,
                    maxLength: maxVinSize,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.characters,
                    onEditComplete: () => context.requestFocus(
                      currentFocus: _vinFN,
                      nextFocus: _mileageFN,
                    ),
                    errorText: viewModel.errorMessage,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                    ],
                    onChanged: (String text) {
                      //TODO:Validate the VIN here.
                    },
                    validator: (value) =>
                        OttoFormValidator.vinCodeValidator(value!),
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                  KFormField(
                    key: _mileageKey,
                    controller: _mileageFieldController,
                    focusNode: _mileageFN,
                    hintText: context.lang.mileage,
                    marginBottom: 15,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatter: [ThousandsInputFormatter()],
                    validator: (value) =>
                        OttoFormValidator.integerValidator(value!),
                  ),
                  // Show Vehicle card info
                  if (viewModel.vehicleInfo != null)
                    Container(
                      width: context.width,
                      padding: context.insetsAll(20),
                      margin: context.insetsOnly(bottom: 15),
                      decoration: const BoxDecoration(
                        color: OttoColor.neutral100,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.vehicleInfo?.make?.toUpperCase() ?? '',
                            style: OttoFont.h4(
                              context,
                              fontWeight: OttoFontWeight.bold,
                            ),
                          ),
                          Text(
                            "${viewModel.vehicleInfo?.model} - ${viewModel.vehicleInfo?.year.toString()}",
                            style: OttoFont.body(context),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: _formIsFilledStateEmitter,
              builder: (_, bool isFormFilled, __) {
                return KButton(
                  onPressed: () {
                    //TODO:Save vehicle details in local storage.
                  },
                  isLoading: viewModel.busy,
                  isDisabled: !isFormFilled || !viewModel.validVin,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
