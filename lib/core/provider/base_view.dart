import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otto_app/core/provider/base_notifier.dart';
import 'package:otto_flutter_core/config/DI/di.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseNotifier> extends StatefulWidget {
  ///The will be used when a function needs to be invoked
  ///once a screen/widget is in view.
  final Function(T)? onModelReady;
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  const BaseView({
    Key? key,
    this.onModelReady,
    required this.builder,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseNotifier> extends State<BaseView<T>> {
  T? model = locator<T>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.onModelReady != null) {
        widget.onModelReady!(model!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model!,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
