import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/overview_quizzfly_item_model.dart';

// ignore: must_be_immutable
class OverviewListItemWidget extends StatelessWidget {
  OverviewListItemWidget(this.overviewQuizzflyItemModelObj, {Key? key})
      : super(
          key: key,
        );

  OverviewQuizzflyItemModel overviewQuizzflyItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.h, // Increased width to accommodate the content better
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(overviewQuizzflyItemModelObj.ten!,
              style: CustomTextStyles.titleMediumPrimaryContainer),
          SizedBox(height: 4.h),
          Text(overviewQuizzflyItemModelObj.questions!,
              style: CustomTextStyles.titleSmallRobotoSansBlack900)
        ],
      ),
    );
  }
}
