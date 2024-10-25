import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/quiz_list_item_model.dart';

// ignore_for_file: must_be_immutable
class QuizListItemWidget extends StatelessWidget {
  QuizListItemWidget(this.quizListItemModelObj, {Key? key})
      : super(
          key: key,
        );
  QuizListItemModel quizListItemModelObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder8,
        border: Border.all(
          color: appTheme.blueGray10002,
          width: 0.5.h,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imageBackToSchool,
            height: 96.h,
            width: 118.h,
            radius: BorderRadius.circular(
              10.h,
            ),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 6.h,
            ),
            child: Text(
              quizListItemModelObj.one!,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 6.h,
              top: 6.h,
            ),
            child: Text(
              quizListItemModelObj.tf!,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 6.h,
              top: 6.h,
            ),
            child: Text(
              quizListItemModelObj.quiz!,
              style: theme.textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
