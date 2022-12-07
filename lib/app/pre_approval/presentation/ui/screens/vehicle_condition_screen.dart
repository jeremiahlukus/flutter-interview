import 'package:flutter/material.dart';
import 'package:otto_app/app/pre_approval/constant.dart';
import 'package:otto_app/src/components/app_bar/progress_indicator_model.dart';
import 'package:otto_app/src/components/widgets/k_base_screen_layout.dart';

class VehicleConditionScreen extends StatefulWidget {
  const VehicleConditionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VehicleConditionScreen> createState() => _VehicleConditionScreenState();
}

class _VehicleConditionScreenState extends State<VehicleConditionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO:Design the vehicle condition screen, design is on the figma file https://www.figma.com/file/A08yUCezjARokegdl4rtiN/Test?node-id=0%3A1.
    //PS: You can go over other user interface designs to see custom widget that are used.
    //In this screen you will need:
    /* *
    * KHeaderWidget (title & description are already defined in the localization file)
    * KRadioButton (We have the VehicleCondition enum is already defined)
    * YMargin (For spacing vertically)
    * KButton
    */

    return KBaseScreenLayout(
      progressModel: ProgressModel(4, totalPreApprovalScreens),
      content: Container(),
    );
  }
}
