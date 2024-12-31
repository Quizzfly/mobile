import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';
import '../models/quiz_list_item_model.dart';

class QuizListItemWidget extends StatelessWidget {
  final QuizListItemModel model;

  const QuizListItemWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(color: appTheme.blueGray100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${model.questionNumber} - ",
                style: CustomTextStyles.titleMediumRobotoBlack900,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  model.questionContent ?? "lbl_untitled".tr,
                  style: CustomTextStyles.titleMediumRobotoBlack900,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                decoration: BoxDecoration(
                  color: appTheme.blue100,
                  borderRadius: BorderRadius.circular(4.h),
                ),
                child: Text(
                  model.questionType ?? "lbl_quiz".tr,
                  style: CustomTextStyles.bodySmallGray90001,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            model.quizType ?? "lbl_untitled".tr,
            style: CustomTextStyles.bodyMediumRobotoGray90003,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 16.h,
                color: appTheme.blueGray400,
              ),
              SizedBox(width: 4.h),
              Text(
                "${model.timeLimit}s",
                style: CustomTextStyles.bodySmallGray90001,
              ),
              SizedBox(width: 4.h),
            ],
          ),
        ],
      ),
    );
  }
}
