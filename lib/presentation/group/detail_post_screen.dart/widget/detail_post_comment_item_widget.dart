import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../models/detail_post_comment_item_model.dart';

// ignore_for_file: must_be_immutable
class DetailPostCommentItemWidget extends StatelessWidget {
  DetailPostCommentItemWidget(this.detailPostCommentItemModelObj, {super.key});
  DetailPostCommentItemModel detailPostCommentItemModelObj;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: detailPostCommentItemModelObj.memberAvatar,
          height: 32.h,
          width: 32.h,
          radius: BorderRadius.circular(
            16.h,
          ),
          fit: BoxFit.cover,
        ),
        SizedBox(width: 8.h),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.gray10001,
                    borderRadius: BorderRadiusStyle.roundedBorder20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detailPostCommentItemModelObj.memberName!,
                        style: CustomTextStyles.labelMediumBlack900,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        detailPostCommentItemModelObj.content!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.bodySmallGray90001.copyWith(
                          height: 1.33,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      Icon(
                        Icons.comment_outlined,
                        size: 12.h,
                        color: appTheme.gray500,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: Text(
                          detailPostCommentItemModelObj.countReplies!.toString(),
                          style: CustomTextStyles.bodySmallGray90001,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
