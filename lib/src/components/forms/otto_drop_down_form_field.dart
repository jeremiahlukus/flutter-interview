import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otto_app/src/components/forms/helpers/form_field_helper.dart';
import 'package:otto_app/src/components/forms/states/focus_state.dart';
import 'package:otto_app/src/components/widgets/k_circular_progress_indicator.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/assets/svgs/icons.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class KDropDownFormField extends StatefulWidget {
  const KDropDownFormField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.inputFormatter,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.prefixIcon,
    this.hintText,
    this.prefixText,
    this.labelText,
    this.descriptionText,
    this.errorText,
    this.readOnly = false,
    this.isRequired = true,
    this.isLoading = false,
    this.showCursor = true,
    this.marginBottom = 15.0,
    this.emptyFieldErrorText,
    this.onDropDownTapped,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatter;
  final FormFieldValidator<String?>? validator;
  final Function(String value)? onChanged;
  final int? maxLength;
  final Widget? prefixIcon;
  final String? hintText, prefixText, labelText, descriptionText, errorText;
  final bool isRequired, isLoading, readOnly, showCursor;
  final double marginBottom;
  final String? emptyFieldErrorText;
  final VoidCallback? onDropDownTapped;

  @override
  _KDropDownFormFieldState createState() => _KDropDownFormFieldState();
}

class _KDropDownFormFieldState extends State<KDropDownFormField>
    with WidgetsBindingObserver {
  final _inputFocus = FocusNode();
  final focusHelper = OttoFormFocusHelper();

  late ValueNotifier<String?> errorTextNotifier;

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
  }

  @override
  void didUpdateWidget(covariant KDropDownFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final _hasError =
        (widget.errorText != null || (widget.errorText?.isNotEmpty ?? false));

    if (_hasError) {
      focusHelper.focusState.value = FocusState(
        hasValue: widget.controller.text.isNotEmpty,
        isFocused: widget.focusNode?.hasFocus ?? _inputFocus.hasFocus,
        hasError: true,
      );
      errorTextNotifier.value = widget.errorText;
    } else {
      errorTextNotifier.value = null;
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
          return GestureDetector(
            onTap: () {
              if (!widget.readOnly) {
                context.resetFocus;
                if (widget.onDropDownTapped != null) {
                  widget.onDropDownTapped!();
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: (focusState.isFocused! || focusState.hasError!)
                            ? 2
                            : 1,
                        color: focusHelper.borderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IgnorePointer(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: widget.controller,
                      inputFormatters: widget.inputFormatter,
                      focusNode: widget.focusNode ?? _inputFocus,
                      readOnly: widget.readOnly,
                      onChanged: widget.onChanged,
                      showCursor: widget.showCursor,
                      validator: (String? value) {
                        /// If is required is false.
                        if (widget.isRequired) {
                          //If the text field is empty.
                          if (value!.isEmpty) {
                            final error = widget.validator!(value);

                            WidgetsBinding.instance?.addPostFrameCallback(
                              (timeStamp) {
                                focusHelper.focusState.value = FocusState(
                                  hasError: error != null,
                                  hasValue: focusState.hasValue ?? false,
                                );
                                errorTextNotifier.value =
                                    widget.emptyFieldErrorText ??
                                        context.lang.filedIsRequired;
                              },
                            );

                            return errorTextNotifier.value;
                          } else {
                            //If the field is required and there is no validation.
                            if (widget.validator == null) {
                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((timeStamp) {
                                focusHelper.focusState.value = FocusState(
                                  hasValue: focusState.hasValue ?? false,
                                );
                              });
                              return null;
                            } else {
                              final validator = widget.validator!(value);

                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((timeStamp) {
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
                          if ((value?.isNotEmpty ?? false) &&
                              (widget.validator != null)) {
                            final validator = widget.validator!(value);

                            WidgetsBinding.instance?.addPostFrameCallback(
                              (timeStamp) {
                                focusHelper.focusState.value = FocusState(
                                  hasError: validator != null,
                                  hasValue: focusState.hasValue ?? false,
                                );
                                errorTextNotifier.value = validator;
                              },
                            );

                            return errorTextNotifier.value;
                          } else {
                            focusHelper.focusState.value = FocusState(
                              hasError: false,
                              hasValue: focusState.hasValue ?? false,
                            );
                            return null;
                          }
                        }
                      },
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
                                  top: (_inputFocus.hasFocus ||
                                          widget.controller.text.isNotEmpty)
                                      ? 12.0
                                      : 0.0,
                                  right: 4,
                                  left: 8,
                                ),
                                child: widget.prefixIcon,
                              )
                            : null,
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 32,
                          maxWidth: 32,
                        ),
                        prefixStyle: OttoFont.h4(
                          context,
                          fontWeight: OttoFontWeight.medium,
                          fontColor: OttoColor.neutral700,
                        ),
                        hintText: widget.hintText,
                        hintStyle: OttoFont.body(
                          context,
                          fontColor: OttoColor.neutral600,
                        ),
                        suffixIcon: Padding(
                          padding: context.insetsOnly(right: 16.0),
                          child: widget.isLoading
                              ? const KCircularProgressLoader(
                                  color: OttoColor.primaryBlue600,
                                )
                              : SvgPicture.asset(
                                  kSvgArrowDown,
                                  color: widget.readOnly
                                      ? OttoColor.neutral300
                                      : null,
                                ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 20,
                        ),
                        errorStyle: OttoFont.sub(context).copyWith(
                          height: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.descriptionText != null ||
                    (focusState.hasError ?? false))
                  const YMargin(8),

                //Description test.
                if (widget.descriptionText != null &&
                    (!focusState.hasError!) &&
                    (focusState.isFocused!))
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
            ),
          );
        },
      ),
    );
  }
}
