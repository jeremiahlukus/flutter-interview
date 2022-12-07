import 'package:flutter/material.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/widgets/searchable_list_item.dart';
import 'package:otto_app/src/extensions/src/context_extensions.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';
import 'package:otto_app/src/scaler/src/extensions.dart';

const svgMakesLogosPath = 'assets/svgs/appraisal/makes';

// ignore: must_be_immutable
class SearchableList<T> extends StatefulWidget {
  T? selectedItem;
  Function(T)? onSelected;
  bool Function(T, String)? filterFn;
  String Function(T)? itemAsStringFn;
  List<T> items;
  bool showSearchInput;
  bool highlightFirstLetter;
  bool multiSelection;
  String listTitle;
  String searchHintText;

  SearchableList(
      {Key? key,
      required this.items,
      this.filterFn,
      this.itemAsStringFn,
      this.onSelected,
      this.selectedItem,
      this.showSearchInput = true,
      this.highlightFirstLetter = true,
      this.multiSelection = false,
      this.listTitle = '',
      this.searchHintText = ''})
      : super(key: key);

  @override
  State<SearchableList<T>> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  final _searchInputFilled = ValueNotifier<bool>(false);
  late ValueNotifier<List<T>> _filteredItems;
  late TextEditingController _searchFieldController;
  late List<T> _selectedItems;

  @override
  void initState() {
    _selectedItems = widget.selectedItem != null ? [widget.selectedItem!] : [];
    _filteredItems = ValueNotifier<List<T>>(widget.items);
    if (widget.showSearchInput) {
      _searchFieldController = TextEditingController(text: '')
        ..addListener(() {
          _searchInputFilled.value = _searchFieldController.text.isNotEmpty;
        });
      if (widget.filterFn != null) {
        _searchFieldController.addListener(() {
          if (_searchFieldController.text.isNotEmpty) {
            _filteredItems.value = widget.items
                .where(
                  (item) => widget.filterFn!(item, _searchFieldController.text),
                )
                .toList();
          } else {
            _filteredItems.value = widget.items;
          }
        });
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _filteredItems.dispose();
    if (widget.showSearchInput) _searchFieldController.dispose();
    super.dispose();
  }

  String _getItemString(dynamic item) {
    return widget.itemAsStringFn != null
        ? widget.itemAsStringFn!(item)
        : item.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.listTitle.isNotEmpty)
          Center(
            child: Text(
              widget.listTitle,
              style: OttoFont.h3(context, fontColor: OttoColor.neutral700),
            ),
          ),
        if (widget.showSearchInput)
          Container(
            height: 35,
            margin: context.insetsOnly(bottom: 10),
            child: ValueListenableBuilder(
                valueListenable: _searchInputFilled,
                builder: (_, bool isFilled, __) {
                  return TextFormField(
                    controller: _searchFieldController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: OttoColor.neutral200,
                      ),
                      suffixIcon: isFilled
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                _searchFieldController.text = '';
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: OttoColor.primaryBlue600,
                              ),
                            )
                          : null,
                      hintText: widget.searchHintText.isEmpty
                          ? context.lang.searchAnything
                          : widget.searchHintText,
                      hintStyle: OttoFont.body(context),
                      contentPadding: EdgeInsets.zero,
                      fillColor: OttoColor.neutral200,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide:
                            const BorderSide(color: OttoColor.neutral200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide:
                            const BorderSide(color: OttoColor.primaryBlue600),
                      ),
                    ),
                  );
                }),
          ),
        Flexible(
          child: ValueListenableBuilder(
            valueListenable: _filteredItems,
            builder: (_, List<T> filteredItems, __) {
              return ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (widget.multiSelection) {
                        if (_selectedItems.contains(filteredItems[index])) {
                          _selectedItems.remove(filteredItems[index]);
                        } else {
                          _selectedItems.add(filteredItems[index]);
                        }
                      } else {
                        _selectedItems = [filteredItems[index]!];
                      }
                      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                      _filteredItems.notifyListeners();
                      widget.onSelected!(filteredItems[index]);
                    },
                    child: SearchableListItem(
                      isSelected: _selectedItems.contains(filteredItems[index]),
                      highlightFirstLetter: widget.highlightFirstLetter,
                      itemText: _getItemString(filteredItems[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
