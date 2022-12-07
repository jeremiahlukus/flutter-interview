import 'package:flutter/material.dart';

class BaseNotifier extends ChangeNotifier {
  ///This will be used mostly in the buttons and screen that has just 2 changes
  ///Loading or not loading.
  bool _busy = false;
  bool get busy => _busy;
  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }

  ///[ListState] to be used for fetching list of items.
  ListState _listState = ListState.initial;
  ListState get listState => _listState;

  void setListState(ListState listState) {
    _listState = listState;
    notifyListeners();
  }
}

enum ListState { initial, loading, hasData, isEmpty, hasError, noInternet }
