import 'package:flutter/material.dart';
import 'package:otto_app/app/pre_approval/constant.dart';
import 'package:otto_app/app/pre_approval/domain/params/params.dart';
import 'package:otto_app/app/pre_approval/presentation/logic/view_models/user_details_view_model.dart';
import 'package:otto_app/core/provider/base_view.dart';
import 'package:otto_app/src/components/app_bar/progress_indicator_model.dart';
import 'package:otto_app/src/components/buttons/k_button.dart';
import 'package:otto_app/src/components/forms/formatters/lower_case_formatter.dart';
import 'package:otto_app/src/components/forms/helpers/validator_helper.dart';
import 'package:otto_app/src/components/forms/otto_form_field.dart';
import 'package:otto_app/src/components/toast/k_toast.dart';
import 'package:otto_app/src/components/widgets/k_base_screen_layout.dart';
import 'package:otto_app/src/components/widgets/k_header_widget.dart';
import 'package:otto_app/src/components/widgets/k_options.dart';
import 'package:otto_app/src/components/widgets/k_styled_text.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formStateEmitter = ValueNotifier<bool>(true);
  final _preferredLanguageEmitter = ValueNotifier<bool>(false);

  //Keys.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Key _firstNameKey = UniqueKey();
  final Key _lastNameKey = UniqueKey();
  final Key _emaiKey = UniqueKey();

  //Controllers
  late TextEditingController _firstNameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _emailCtrl;

  //FocusNode
  final FocusNode _firstNameFN = FocusNode();
  final FocusNode _lastNameFN = FocusNode();
  final FocusNode _emailFN = FocusNode();

  String? _preferredLanguage;

  @override
  void initState() {
    super.initState();

    //TODO:Populate text field with user data saved in local storage.

    _firstNameCtrl = TextEditingController(text: '')
      ..addListener(() {
        _formStateEmitter.value = _formfilledStatus();
      });

    _lastNameCtrl = TextEditingController(text: '')
      ..addListener(() {
        _formStateEmitter.value = _formfilledStatus();
      });

    _emailCtrl = TextEditingController(text: '')
      ..addListener(() {
        _formStateEmitter.value = _formfilledStatus();
      });

    _preferredLanguageEmitter.addListener(() {
      _formStateEmitter.value = _formfilledStatus();
    });

    //For pre-filling our form fields.
    //
    //We will set the value of the [_formfilledStatus] to formStateEmitter
    //To check button disabled state.
    _formStateEmitter.value = _formfilledStatus();
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();

    _formStateEmitter.dispose();

    super.dispose();
  }

  bool _formfilledStatus() {
    return OttoFormValidator.firstNameValidator(_firstNameCtrl.text) != null ||
        OttoFormValidator.lastNameValidator(_lastNameCtrl.text) != null ||
        OttoFormValidator.emailValidator(_emailCtrl.text) != null ||
        _preferredLanguageEmitter.value == false;
  }

  @override
  Widget build(BuildContext context) {
    return KBaseScreenLayout(
      progressModel: ProgressModel(1, totalPreApprovalScreens),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            KHeaderWidget(
              title: context.lang.basicInfoTitle,
              description: context.lang.basicInfoDesc,
            ),
            KFormField(
              key: _firstNameKey,
              controller: _firstNameCtrl,
              focusNode: _firstNameFN,
              textCapitalization: TextCapitalization.words,
              hintText: context.lang.firstName,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onEditComplete: () => context.requestFocus(
                currentFocus: _firstNameFN,
                nextFocus: _lastNameFN,
              ),
              validator: (value) =>
                  OttoFormValidator.firstNameValidator(value!),
            ),
            KFormField(
              key: _lastNameKey,
              controller: _lastNameCtrl,
              focusNode: _lastNameFN,
              textCapitalization: TextCapitalization.words,
              hintText: context.lang.lastName,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onEditComplete: () => context.requestFocus(
                currentFocus: _lastNameFN,
                nextFocus: _emailFN,
              ),
              validator: (value) => OttoFormValidator.lastNameValidator(value!),
            ),
            KFormField(
              key: _emaiKey,
              controller: _emailCtrl,
              focusNode: _emailFN,
              hintText: context.lang.emailAddress,
              keyboardType: TextInputType.emailAddress,
              inputFormatter: [LowerCaseTextFormatter()],
              textInputAction: TextInputAction.done,
              validator: (value) => OttoFormValidator.emailValidator(value!),
            ),
            const YMargin(5),
            Text(
              context.lang.preferredLanguage,
              style: OttoFont.body(context),
            ),
            const YMargin(10),
            KOptions(
              options: {
                'english': context.lang.english,
                'spanish': context.lang.spanish,
              },
              initialSelection: _preferredLanguage,
              onSelect: (value) {
                _preferredLanguage = value;
                _preferredLanguageEmitter.value = true;
                context.resetFocus;
              },
            ),
            const YMargin(30),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const YMargin(16),
                KStyledText(
                  context.lang.termsAndPrivacy,
                  textAlign: TextAlign.center,
                  onTap: (value) {
                    if (value == 'patriot act, privacy policy') {
                      KToast(
                        context,
                        title: value ?? '',
                      );
                    }

                    if (value == 'terms private notice') {
                      KToast(
                        context,
                        title: value ?? '',
                      );
                    }
                  },
                ),
                const YMargin(21),
                ValueListenableBuilder(
                  valueListenable: _formStateEmitter,
                  builder: (_, bool isDisabled, __) {
                    return BaseView<UpdateUserDetailsViewModel>(
                      builder: (context, model, __) {
                        return ValueListenableBuilder(
                          valueListenable: _preferredLanguageEmitter,
                          builder: (_, bool hasSelectedLanguage, __) {
                            final _isButtonDisbaled =
                                (isDisabled || !hasSelectedLanguage);

                            return KButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  model.updateUserDetails(
                                    context: context,
                                    params: UserDetailsParams(
                                      firstName: _firstNameCtrl.text,
                                      lastName: _lastNameCtrl.text,
                                      email: _emailCtrl.text,
                                      languagePreference: _preferredLanguage,
                                    ),
                                  );
                                }
                              },
                              isDisabled: _isButtonDisbaled,
                              isUsedInForms: true,
                              isLoading: model.busy,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const YMargin(88),
            Text(
              context.lang.usaPatriotAct,
              textAlign: TextAlign.center,
              style: OttoFont.small(
                context,
                fontColor: OttoColor.neutral500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
