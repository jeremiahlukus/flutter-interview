import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otto_app/src/components/radio_button/k_radio_button.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/scaler.dart';

class KOptions extends StatefulWidget {
  /// Our selection options. It is a key/value, where key<String> is the key and a value<String> that will be displayed
  final Map<String, String> options;

  /// Optional Callback function that will be fired whenever a selection occurs
  final Function(String selectedKey) onSelect;

  /// Optional initial selected Key
  final String? initialSelection;

  const KOptions(
      {Key? key,
      required this.options,
      required this.onSelect,
      this.initialSelection})
      : super(key: key);

  @override
  State<KOptions> createState() => _KOptionsState();
}

class _KOptionsState extends State<KOptions> {
  late ValueNotifier<String?> _optionSelectedEmitter;

  @override
  void initState() {
    String? initial;
    if (widget.options.keys.contains(widget.initialSelection)) {
      initial = widget.initialSelection;
    }
    _optionSelectedEmitter = ValueNotifier<String?>(initial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _optionSelectedEmitter,
      builder: (context, String? selectedOption, _) {
        return CupertinoSegmentedControl<String>(
          borderColor: Colors.transparent,
          pressedColor: Colors.transparent,
          selectedColor: Colors.transparent,
          unselectedColor: Colors.transparent,
          padding: context.insetsAll(0),
          children: _getOptions(context, selectedOption ?? ''),
          groupValue: selectedOption,
          onValueChanged: (value) {
            _optionSelectedEmitter.value = value;
            widget.onSelect(value);
          },
        );
      },
    );
  }

  Map<String, Widget> _getOptions(BuildContext context, String selected) {
    Map<String, Widget> ret = {};
    int optionsListSize = widget.options.keys.length;
    int index = 1;
    widget.options.forEach(
      (String key, String value) {
        ret[key] = Padding(
          padding: context.insetsOnly(right: index != optionsListSize ? 10 : 0),
          child: Container(
            padding: context.insetsSymetric(horizontal: 16.0, vertical: 12.0),
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: OttoColor.white,
              border: Border.all(
                color: key != selected
                    ? OttoColor.neutral200
                    : OttoColor.primaryBlue600,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KRadioButton(
                  value: value,
                  groupValue: (key == selected) ? value : '',
                  onChanged: (_) {},
                ),
                const SizedBox(width: 10),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: OttoFont.small(
                    context,
                    fontWeight: OttoFontWeight.medium,
                    fontColor: (key == selected)
                        ? OttoColor.neutral700
                        : OttoColor.neutral900,
                  ),
                ),
              ],
            ),
          ),
        );
        index++;
      },
    );

    return ret;
  }
}
