import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/recent_activities_grid_item_model.dart';

// ignore_for_file: must_be_immutable
class RecentActivitiesGridItemWidget extends StatelessWidget {
  RecentActivitiesGridItemWidget(this.recentActivitiesGridItemModelObj,
      {super.key});
  RecentActivitiesGridItemModel recentActivitiesGridItemModelObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder8,
        border: Border.all(
          color: appTheme.blueGray10002,
          width: 0.5.h,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: recentActivitiesGridItemModelObj.imagePath,
            height: 102.h,
            width: double.maxFinite,
            radius: BorderRadius.vertical(
              top: Radius.circular(10.h),
            ),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 6.h),
              child: Text(
                recentActivitiesGridItemModelObj.title!,
                style: CustomTextStyles.bodyMediumBlack900_1,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recentActivitiesGridItemModelObj.date!,
                  style: CustomTextStyles.bodySmallGray90001,
                ),
                const Spacer(),
                Icon(
                  Icons.visibility,
                  color: appTheme.blueGray300,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.h,
                    right: 8.h,
                  ),
                  child: Text(
                    'View',
                    style: CustomTextStyles.bodySmallGray90001,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }
}
