import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otto_app/src/components/forms/helpers/form_field_helper.dart';
import 'package:otto_app/src/components/forms/helpers/validator_helper.dart';
import 'package:otto_app/src/components/forms/states/focus_state.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

@immutable
class KFormField extends StatefulWidget {
  const KFormField({
    required Key key,
    required this.controller,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatter,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onEditComplete,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.prefixText,
    this.descriptionText,
    this.errorText,
    this.obscureText = false,
    this.readOnly = false,
    this.isRequired = true,
    this.isEnabled = true,
    this.autoFocus = false,
    this.marginBottom = 15.0,
    this.prefixStyle,
    this.emptyFieldErrorText,
    this.formKey,
    this.autovalidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String?>? validator;
  final Function(String value)? onChanged;
  final VoidCallback? onEditComplete;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText, labelText, prefixText, descriptionText, errorText;
  final bool obscureText, isRequired, readOnly, autoFocus, isEnabled;
  final TextStyle? prefixStyle;
  final double marginBottom;
  final String? emptyFieldErrorText;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;

  @override
  _KFormFieldState createState() => _KFormFieldState();
}

class _KFormFieldState extends State<KFormField> {
  final _inputFocus = FocusNode();
  final focusHelper = OttoFormFocusHelper();

  late ValueNotifier<String?> errorTextNotifier;
  late AutovalidateMode _autoValidateMode;

  @override
  void initState() {
    super.initState();
    (widget.focusNode ?? _inputFocus).addListener(() {
      focusHelper.focusState.value = FocusState(
        hasValue: widget.controller.text.isNotEmpty,
        isFocused: widget.focusNode?.hasFocus ?? _inputFocus.hasFocus,
      );
    });

    errorTextNotifier = ValueNotifier(null);
    _autoValidateMode = widget.autovalidateMode!;
  }

  @override
  void didUpdateWidget(covariant KFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final _hasError = (widget.errorText != null || (widget.errorText?.isNotEmpty ?? false));

    if (_hasError) {
      focusHelper.focusState.value = FocusState(
        hasValue: widget.controller.text.isNotEmpty,
        isFocused: widget.focusNode?.hasFocus ?? _inputFocus.hasFocus,
        hasError: true,
      );
      errorTextNotifier.value = widget.errorText;
      _autoValidateMode = AutovalidateMode.disabled;
    }
  }

  @override
  void dispose() {
    errorTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.insetsOnly(bottom: widget.marginBottom),
      child: ValueListenableBuilder(
        valueListenable: focusHelper.focusState,
        builder: (context, FocusState focusState, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: (focusState.isFocused! || focusState.hasError!) ? 2 : 1,
                    color: focusHelper.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FocusScope(
                  onFocusChange: (value) {
                    if (!value) {
                      if ((widget.isRequired) && widget.validator != null) {
                        final validator = widget.validator!(widget.controller.text);

                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          focusHelper.focusState.value = FocusState(
                            hasError: validator != null,
                            hasValue: focusState.hasValue ?? false,
                          );
                          errorTextNotifier.value = validator;
                        });

                        errorTextNotifier.value;
                      }
                    }
                    if (value && (focusState.hasError ?? false)) {
                      widget.formKey?.currentState?.validate();
                    }
                  },
                  child: TextFormField(
                    autovalidateMode: _autoValidateMode,
                    controller: widget.controller,
                    textCapitalization: widget.textCapitalization,
                    inputFormatters: widget.inputFormatter,
                    textInputAction: widget.textInputAction,
                    keyboardType: widget.keyboardType,
                    focusNode: widget.focusNode ?? _inputFocus,
                    readOnly: widget.readOnly,
                    enabled: widget.isEnabled,
                    onChanged: widget.onChanged,
                    onEditingComplete: widget.onEditComplete,
                    autofocus: widget.autoFocus,
                    keyboardAppearance: Brightness.light,
                    onFieldSubmitted: (_) {
                      if (widget.textInputAction == TextInputAction.done) {
                        context.resetFocus;
                      }

                      widget.formKey?.currentState?.validate();
                    },
                    validator: (String? value) {
                      /// If isRequired is false.
                      if (widget.isRequired) {
                        //If the text field is empty.
                        if (value?.isEmpty ?? false) {
                          final error = OttoFormValidator.isEmpty(value);

                          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                            focusHelper.focusState.value = FocusState(
                              hasError: error != null,
                              hasValue: focusState.hasValue ?? false,
                            );
                            errorTextNotifier.value = widget.emptyFieldErrorText ?? context.lang.filedIsRequired;
                          });

                          return errorTextNotifier.value;
                        } else {
                          //If the field is required and there is no validation.
                          if (widget.validator == null) {
                            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                              focusHelper.focusState.value = FocusState(
                                hasValue: focusState.hasValue ?? false,
                              );
                            });
                            return null;
                          } else {
                            final validator = widget.validator!(value);

                            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                              focusHelper.focusState.value = FocusState(
                                hasError: validator != null,
                                hasValue: focusState.hasValue ?? false,
                              );
                              errorTextNotifier.value = validator;
                            });

                            return errorTextNotifier.value;
                          }
                        }
                      } else {
                        if ((value?.isNotEmpty ?? false) && (widget.validator != null)) {
                          final validator = widget.validator!(value);

                          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                            focusHelper.focusState.value = FocusState(
                              hasError: validator != null,
                              hasValue: focusState.hasValue ?? false,
                            );
                            errorTextNotifier.value = validator;
                          });

                          return errorTextNotifier.value;
                        } else {
                          WidgetsBinding.instance?.addPostFrameCallback(
                            (_) {
                              focusHelper.focusState.value = FocusState(
                                hasError: false,
                                hasValue: focusState.hasValue ?? false,
                              );
                            },
                          );
                          return null;
                        }
                      }
                    },
                    obscureText: widget.obscureText,
                    maxLength: widget.maxLength,
                    style: OttoFont.h4(
                      context,
                      fontColor: OttoColor.neutral900,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelStyle: OttoFont.sub(
                        context,
                        fontColor: focusHelper.floatingLabelColor,
                      ),
                      labelText: widget.labelText ?? widget.hintText,
                      labelStyle: OttoFont.body(
                        context,
                        fontColor: OttoColor.neutral600,
                      ),
                      counterText: '',
                      contentPadding: context.insetsSymetric(
                        horizontal: 16.0,
                        vertical: (widget.hintText == null) ? 16.0 : 8.0,
                      ),
                      prefixText: widget.prefixText,
                      prefixIcon: widget.prefixIcon != null
                          ? Padding(
                              padding: context.insetsOnly(
                                top: (_inputFocus.hasFocus || widget.controller.text.isNotEmpty) ? 10.0 : 0.0,
                                right: 4,
                                left: 16,
                              ),
                              child: widget.prefixIcon,
                            )
                          : null,
                      prefixIconConstraints: const BoxConstraints(
                        maxHeight: 32,
                        maxWidth: 32,
                      ),
                      prefixStyle: widget.prefixStyle ??
                          OttoFont.h4(
                            context,
                            fontWeight: OttoFontWeight.medium,
                            fontColor: OttoColor.neutral700,
                          ),
                      hintText: widget.hintText,
                      hintStyle: OttoFont.body(
                        context,
                        fontColor: OttoColor.neutral600,
                      ),
                      suffixIcon: widget.suffixIcon != null ? UnconstrainedBox(child: widget.suffixIcon) : null,
                      errorStyle: OttoFont.sub(context).copyWith(
                        height: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.descriptionText != null || (focusState.hasError ?? false)) const YMargin(8),

              //Description test.
              if (widget.descriptionText != null && (!focusState.hasError!) && (focusState.isFocused!))
                Padding(
                  padding: context.insetsOnly(left: 16),
                  child: Text(
                    widget.descriptionText ?? '',
                    style: OttoFont.sub(
                      context,
                      fontColor: OttoColor.neutral700,
                    ),
                  ),
                ),

              //Error test.
              if ((focusState.hasError ?? false) && (!focusState.isFocused!))
                Padding(
                  padding: context.insetsOnly(left: 16),
                  child: ValueListenableBuilder<String?>(
                    valueListenable: errorTextNotifier,
                    builder: (context, String? value, __) {
                      return Text(
                        value ?? '',
                        style: OttoFont.sub(
                          context,
                          fontColor: OttoColor.red500,
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
