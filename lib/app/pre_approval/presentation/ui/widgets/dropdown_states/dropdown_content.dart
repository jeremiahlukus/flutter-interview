import 'package:flutter/material.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/widgets/dropdown_states/dropdown_error.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/widgets/dropdown_states/dropdown_loading.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/widgets/searchable_list.dart';
import 'package:otto_app/core/provider/base_notifier.dart';
import 'package:otto_app/core/provider/base_view.dart';
import 'package:otto_app/src/extensions/src/context_extensions.dart';
import 'package:otto_app/src/res/assets/assets.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/src/extensions.dart';

class DropdownContent<T, V extends BaseNotifier> extends StatelessWidget {
  final String title;
  final Function(T) onSelected;
  final List<T> Function() items;
  final String Function(T)? itemAsStringFn;
  final bool Function(T, String) filterFn;
  final VoidCallback? retryFn;

  const DropdownContent({
    Key? key,
    required this.title,
    required this.onSelected,
    this.itemAsStringFn,
    required this.filterFn,
    required this.items,
    this.retryFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.insetsSymetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.insetsSymetric(vertical: 20),
            child: Text(
              title,
              style: OttoFont.h3(
                context,
                fontColor: OttoColor.neutral700,
                fontWeight: OttoFontWeight.bold,
              ),
            ),
          ),
          BaseView<V>(
            builder: (_, viewModel, __) {
              switch (viewModel.listState) {
                case ListState.hasData:
                  return Expanded(
                    child: SearchableList<T>(
                      items: items(),
                      onSelected: onSelected,
                      highlightFirstLetter: false,
                      itemAsStringFn: itemAsStringFn,
                      filterFn: filterFn,
                    ),
                  );
                case ListState.isEmpty:
                  return Expanded(
                    child: DropdownError(
                      title: context.lang.somethingIsWrong,
                      description: context.lang.weAreSorryKindlyRetry,
                      imagePath: kSvgError,
                      retryFunction: retryFn,
                    ),
                  );
                case ListState.hasError:
                  return Expanded(
                    child: DropdownError(
                      title: context.lang.somethingIsWrong,
                      description: context.lang.weAreSorryKindlyRetry,
                      imagePath: kSvgError,
                      retryFunction: retryFn,
                    ),
                  );
                case ListState.noInternet:
                  return Expanded(
                    child: DropdownError(
                      title: context.lang.opsNoInternet,
                      description: context.lang.noInternetConnection,
                      imagePath: kSvgNoConnection,
                      retryFunction: retryFn,
                    ),
                  );

                case ListState.loading:
                default:
                  return const Expanded(child: DropdownLoading());
              }
            },
          ),
        ],
      ),
    );
  }
}
