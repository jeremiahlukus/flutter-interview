import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:otto_app/src/components/app_bar/otto_app_bar_with_progress.dart';
import 'package:otto_app/src/components/app_bar/progress_indicator_model.dart';
import 'package:otto_app/src/extensions/extensions.dart';

import 'k_back_button.dart';

class KBaseScreenLayout extends StatelessWidget {
  final Widget content;
  final Widget? button;
  final ProgressModel? progressModel;
  final bool implyLeading;
  final bool hasListView;
  final bool ignoreKeyboardVisibilitRules;

  const KBaseScreenLayout({
    Key? key,
    required this.content,
    this.button,
    this.progressModel,
    this.implyLeading = true,
    this.hasListView = false,
    this.ignoreKeyboardVisibilitRules = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body:
              KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return hasListView
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      progressModel == null
                          ? Padding(
                              padding: context.insetsOnly(
                                left: 16,
                                top: 9,
                                bottom: 9,
                              ),
                              child: const KBackButton(),
                            )
                          : OttoAppBarWithProgress(
                              progressModel: progressModel!,
                              hasBackButton: implyLeading,
                            ),
                      const YMargin(20),
                      Flexible(
                        child: Padding(
                          padding: context
                              .insetsSymetric(horizontal: 20)
                              .copyWith(bottom: !isKeyboardVisible ? 30 : 4.0),
                          child: content,
                        ),
                      ),
                    ],
                  )
                : LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints viewportConstraints,
                    ) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                progressModel == null
                                    ? Padding(
                                        padding: context.insetsOnly(
                                          left: 16,
                                          top: 9,
                                          bottom: 9,
                                        ),
                                        child: implyLeading
                                            ? const KBackButton()
                                            : const Offstage(),
                                      )
                                    : OttoAppBarWithProgress(
                                        progressModel: progressModel!,
                                        hasBackButton: implyLeading,
                                      ),
                                const YMargin(20),
                                Flexible(
                                  child: Padding(
                                    padding: context
                                        .insetsSymetric(horizontal: 20)
                                        .copyWith(
                                          bottom: !isKeyboardVisible ? 30 : 4.0,
                                        ),
                                    child: content,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }),
          bottomNavigationBar: button != null
              ? KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                    ///[ignoreKeyboardVisibilitRules] will be used for screens
                    ///where we still need to show button above keyboard.
                    return ignoreKeyboardVisibilitRules
                        ? Padding(
                            padding: context
                                .insetsSymetric(horizontal: 20)
                                .copyWith(bottom: 35),
                            child: Builder(
                              builder: (_) => button!,
                            ),
                          )
                        : isKeyboardVisible
                            ? const Offstage()
                            : Padding(
                                padding: context
                                    .insetsSymetric(horizontal: 20)
                                    .copyWith(bottom: 35),
                                child: Builder(
                                  builder: (_) => button!,
                                ),
                              );
                  },
                )
              : const Offstage(),
        ),
      ),
    );
  }
}
