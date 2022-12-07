import 'package:flutter/material.dart';
import 'package:otto_app/app/pre_approval/constant.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/tabs/pages/appraise_by_drilldown_page.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/tabs/pages/appraise_by_vin_page.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/widgets/tab_bar.dart';
import 'package:otto_app/src/components/app_bar/progress_indicator_model.dart';
import 'package:otto_app/src/components/widgets/k_base_screen_layout.dart';
import 'package:otto_app/src/components/widgets/k_header_widget.dart';
import 'package:otto_app/src/extensions/extensions.dart';

class VehicleDetailsTabScreen extends StatefulWidget {
  const VehicleDetailsTabScreen({Key? key}) : super(key: key);

  @override
  _VehicleDetailsTabScreenState createState() =>
      _VehicleDetailsTabScreenState();
}

class _VehicleDetailsTabScreenState extends State<VehicleDetailsTabScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        context.resetFocus;
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KBaseScreenLayout(
      implyLeading: false,
      hasListView: true,
      progressModel: ProgressModel(3, totalPreApprovalScreens),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KHeaderWidget(
            title: context.lang.vehicleDetails,
            description: context.lang.whatsYourVehicleInformation,
          ),
          OttoTabBar(
            tabs: [
              context.lang.manualEntry,
              context.lang.useVIN,
            ],
            controller: _tabController,
          ),
          const YMargin(15),
          Flexible(
            fit: FlexFit.loose,
            child: TabBarView(
              controller: _tabController,
              children: [
                LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraint.maxHeight,
                        ),
                        child: const IntrinsicHeight(
                          child: AppraiseByDrilldownPage(),
                        ),
                      ),
                    );
                  },
                ),
                LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraint.maxHeight,
                        ),
                        child: const IntrinsicHeight(
                          child: AppraiseByVinPage(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
