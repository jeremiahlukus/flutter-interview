import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/navigation/navigation.dart';
import 'package:otto_app/src/res/assets/svgs/icons.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';

class KBottomModal {
  Widget Function(ScrollController)? builder;

  //Constructor for normal bottom modal that has fixed value/height.
  ///The[minChildSize],[initialChildSize]&[maxChildSize]
  ///Are not used in so we will use a fixed height.
  KBottomModal({
    required this.ctx,
    required this.modalWidget,
    this.minChildSize = .1,
    this.maxChildSize = .1,
    this.initialChildSize = .1,
    this.fixedHeight,
    this.isDismissable = false,
    this.canDragToClose = false,
    this.isScrollable = false,
    this.canPop = false,
    this.isPadded = true,
    this.padding,
  })  : builder = null,
        isDraggble = false {
    _showModal = _init(ctx);
  }

  KBottomModal.draggable({
    required this.ctx,
    required this.builder,
    this.minChildSize = .3,
    this.initialChildSize = .7,
    this.maxChildSize = .9,
    this.fixedHeight,
    this.isPadded = true,
    this.padding,
  })  : isDraggble = true,
        modalWidget = const Offstage(),
        isScrollable = true,
        canPop = true,
        canDragToClose = true,
        isDismissable = true,
        assert(maxChildSize >= .1 && maxChildSize <= 1),
        assert(minChildSize >= .1 && minChildSize <= 1),
        assert(initialChildSize >= .1 && initialChildSize <= 1) {
    _showModal = _init(ctx);
  }

  final BuildContext ctx;

  ///The view that will be displayed in the modal.
  final Widget modalWidget;

  ///The initial height of the modal from 0.1 - 1.
  final double initialChildSize;

  ///The maximum height of the modal,
  ///the point it should stop scrolling to the top.
  final double maxChildSize;

  ///The least height of the modal,.
  ///the point the modal stop scrolling to the bottom.
  final double minChildSize;

  ///Fixed height for non-draggable modal.
  final double? fixedHeight;

  final EdgeInsetsGeometry? padding;

  ///Weather or not the modal can be dismissed.
  bool isDismissable;
  bool isPadded;

  ///Weather or not the modal accepts being able to drag to close.
  bool canDragToClose;
  bool isDraggble;
  bool canPop;
  bool isScrollable;

  Future? _showModal;

  Container body(BuildContext context, {ScrollController? controller}) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isDismissable)
            InkResponse(
              onTap: () => popView(context),
              child: Padding(
                padding: context.insetsOnly(right: 15, bottom: 10),
                child: SvgPicture.asset(
                  kSvgIconCloseModal,
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          Expanded(
            child: Container(
              padding: padding ??
                  context.insetsSymetric(horizontal: isPadded ? 5 : 0),
              decoration: const BoxDecoration(
                color: OttoColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: controller != null ? builder!(controller) : modalWidget,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _init(BuildContext context) async {
    final res = await showModalBottomSheet(
      context: context,
      isDismissible: isDismissable,
      enableDrag: canDragToClose,
      isScrollControlled: isScrollable,
      builder: (_) {
        if (isDraggble) {
          return DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            builder: (context, scrollController) {
              return body(context, controller: scrollController);
            },
          );
        }
        return WillPopScope(
          onWillPop: () async => canPop,
          child: SizedBox(
            height: context.scaleY(fixedHeight ?? 0),
            child: body(context),
          ),
        );
      },
    );
    return res;
  }

  Future? get showModal => _showModal;
}
