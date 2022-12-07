import 'package:flutter/material.dart';
import 'package:otto_app/app/auth/domain/params/post_params.dart';
import 'package:otto_app/app/auth/presentation/logic/view_models/verify_otp_view_model.dart';
import 'package:otto_app/core/provider/base_view.dart';
import 'package:otto_app/src/components/buttons/k_button.dart';
import 'package:otto_app/src/components/forms/otto_pin_form_field.dart';
import 'package:otto_app/src/components/toast/k_toast.dart';
import 'package:otto_app/src/components/widgets/k_base_screen_layout.dart';
import 'package:otto_app/src/components/widgets/k_header_widget.dart';
import 'package:otto_app/src/extensions/extensions.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String phoneNumber;
  const VerifyOTPScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final _buttonDisabledEmitter = ValueNotifier<bool>(true);

  //Keys.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Key _otpKey = UniqueKey();

  //Controller.
  late TextEditingController _otpCtrl;

  @override
  void initState() {
    super.initState();

    _otpCtrl = TextEditingController();

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        KToast(context, title: context.lang.verificationCodeHasBeenSent);
      },
    );
  }

  @override
  void dispose() {
    _otpCtrl.dispose();
    _buttonDisabledEmitter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyOTPViewModel>(
      builder: (_, model, __) {
        return KBaseScreenLayout(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KHeaderWidget(
                title: context.lang.verifyOTPTitle,
                description:
                    '${context.lang.verifyOTPDesc} ${widget.phoneNumber}',
              ),
              const YMargin(8),
              Form(
                key: _formKey,
                child: KOTPFormField(
                  key: _otpKey,
                  controller: _otpCtrl,
                  autoFocus: true,
                  errorText: model.errorMessage,
                  onCompleted: (_) {
                    _buttonDisabledEmitter.value = false;
                  },
                ),
              ),
              const YMargin(46),
            ],
          ),
          button: ValueListenableBuilder(
            valueListenable: _buttonDisabledEmitter,
            builder: (_, bool isDisabled, __) {
              return isDisabled
                  ? const Offstage()
                  : KButton(
                      onPressed: () {
                        model.restErrorField;

                        if (_formKey.currentState!.validate() || !isDisabled) {
                          model.verifyOTP(
                            context: context,
                            params: VerifyOTPParams(
                              phoneNumber:
                                  widget.phoneNumber.formattedPhoneNumber,
                              code: _otpCtrl.text.removeSpecialCharacters,
                            ),
                          );
                        }
                      },
                      isLoading: model.busy,
                      isDisabled: isDisabled,
                      isUsedInForms: true,
                    );
            },
          ),
        );
      },
    );
  }
}
