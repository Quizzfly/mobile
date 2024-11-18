import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/users_rank_list_item_model.dart';

// ignore_for_file: must_be_immutable
class UsersRankListItemWidget extends StatelessWidget {
  UsersRankListItemWidget(this.usersRankListItemModelObj, {super.key});
  UsersRankListItemModel usersRankListItemModelObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        children: [
          Container(
            width: 24.h,
            height: 24.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.circleBorder12,
              border: Border.all(
                color: appTheme.gray300,
                width: 1.5.h,
              ),
            ),
            child: Text(
              usersRankListItemModelObj.no.toString(),
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge,
            ),
          ),
          SizedBox(width: 16.h),
          CustomImageView(
            imagePath: usersRankListItemModelObj.imageAvatar!,
            height: 56.h,
            width: 56.h,
            radius: BorderRadius.circular(
              28.h,
            ),
            margin: EdgeInsets.only(bottom: 4.h),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usersRankListItemModelObj.nickName!,
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      usersRankListItemModelObj.score.toString(),
                      style: CustomTextStyles.titleSmallGray500,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
