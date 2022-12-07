import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otto_app/src/extensions/extensions.dart';
import 'package:otto_app/src/res/assets/svgs/icons.dart';
import 'package:otto_app/src/res/values/colors/colors.dart';
import 'package:otto_app/src/res/values/styles/text_style.dart';

class SearchableListItem extends StatelessWidget {
  final String itemText;
  final bool highlightFirstLetter;
  final Widget? leading;
  final bool isSelected;
  const SearchableListItem({
    Key? key,
    required this.itemText,
    this.highlightFirstLetter = true,
    this.leading,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.insetsSymetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (highlightFirstLetter)
            CircleAvatar(
              maxRadius: 16,
              minRadius: 16,
              backgroundColor: OttoColor.neutral300,
              child: Text(
                itemText.firstLetter.toUpperCase(),
                style: OttoFont.body(context),
              ),
            ),
          if (leading != null)
            SizedBox(
              height: 24,
              width: 24,
              child: leading,
            ),
          const XMargin(10),
          Expanded(
            child: Padding(
              padding: context.insetsSymetric(vertical: 12),
              child: Text(
                itemText,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: OttoFont.body(
                  context,
                  fontColor: OttoColor.black,
                ),
              ),
            ),
          ),
          if (isSelected)
            SizedBox(
              child: SvgPicture.asset(
                kSvgIconCheck,
                color: OttoColor.primaryBlue500,
              ),
            ),
        ],
      ),
    );
  }
}
