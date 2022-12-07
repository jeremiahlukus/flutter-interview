import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:otto_app/app/auth/presentation/logic/view_models/login_register_view_model.dart';
import 'package:otto_app/core/provider/base_view.dart';
import 'package:otto_app/src/components/buttons/k_button.dart';
import 'package:otto_app/src/components/dialog/k_alert_dialog.dart';
import 'package:otto_app/src/components/forms/helpers/validator_helper.dart';
import 'package:otto_app/src/components/forms/otto_form_field.dart';
import 'package:otto_app/src/components/toast/k_toast.dart';
import 'package:otto_app/src/components/widgets/k_base_screen_layout.dart';
import 'package:otto_app/src/components/widgets/k_header_widget.dart';
import 'package:otto_app/src/components/widgets/k_styled_text.dart';
import 'package:otto_app/src/extensions/extensions.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  final bool tokenTimeOut;
  const LoginOrRegisterScreen({Key? key, this.tokenTimeOut = false})
      : super(key: key);

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  final _formStateEmitter = ValueNotifier<bool>(true);

  ///Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Key _phoneNumberKey = UniqueKey();

  //Controller
  late TextEditingController _phoneNumberCtrl;

  @override
  void initState() {
    super.initState();

    _phoneNumberCtrl = TextEditingController(text: '')
      ..addListener(() {
        _formStateEmitter.value = _formfilledStatus();
      });

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        if (widget.tokenTimeOut) {
          KAlertDialog.dialog(
            context,
            title: context.lang.yourSessionHasExpired,
            description: context.lang.pleaseLoginAgain,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _phoneNumberCtrl.dispose();

    _formStateEmitter.dispose();
    super.dispose();
  }

  bool _formfilledStatus() {
    return OttoFormValidator.phoneNumberValidator(_phoneNumberCtrl.text) !=
        null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginRegsiterViewModel>(
      builder: (_, model, __) {
        return KBaseScreenLayout(
          implyLeading: false,
          ignoreKeyboardVisibilitRules: true,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              KHeaderWidget(
                title: context.lang.loginToOtto,
                description: context.lang.enterPhoneNumberHere,
              ),
              Form(
                key: _formKey,
                child: KFormField(
                  key: _phoneNumberKey,
                  controller: _phoneNumberCtrl,
                  labelText: context.lang.phoneNumber,
                  autovalidateMode: AutovalidateMode.disabled,
                  hintText: '(000) 000-0000',
                  prefixText: '+1 ',
                  marginBottom: 25,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  errorText: model.phoneNumberFieldError,
                  emptyFieldErrorText: context.lang.emptyPhoneFieldError,
                  inputFormatter: [
                    MaskTextInputFormatter(
                      mask: '(###) ###-####',
                    ),
                  ],
                  validator: (value) =>
                      OttoFormValidator.phoneNumberValidator(value!),
                ),
              ),
            ],
          ),
          button: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KStyledText(
                context.lang.phoneNumberAgreement,
                textAlign: TextAlign.center,
                onTap: (String? value) {
                  if (value == 'electronic communications disclosure') {
                    KToast(
                      context,
                      title: value ?? '',
                    );
                  }

                  if (value == 'terms of service') {
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
                builder: (_, bool isDisabled, mode) {
                  return KButton(
                    onPressed: () {
                      model.resetErrorField;

                      if (_formKey.currentState!.validate() || !isDisabled) {
                        model.loginWithPhoneNumber(
                          context: context,
                          phoneNumber: '+1 ${_phoneNumberCtrl.text}',
                        );
                      }
                    },
                    isLoading: model.busy,
                    isDisabled: isDisabled,
                    isUsedInForms: true,
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
