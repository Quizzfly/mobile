import 'package:flutter/material.dart';
import '../../../../../core/app_export.dart';
import '../../../../../theme/custom_button_style.dart';
import '../../../../../widgets/custom_elevated_button.dart';
import '../models/library_list_item_model.dart';

// ignore_for_file: must_be_immutable
class LibraryListItemWidget extends StatelessWidget {
  LibraryListItemWidget(this.libraryListItemModelObj,
      {super.key, this.callDetail, this.onDelete});

  LibraryListItemModel libraryListItemModelObj;

  VoidCallback? callDetail;

  Function(String)? onDelete;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callDetail?.call();
      },
      child: Container(
        decoration: BoxDecoration(
            color: appTheme.whiteA700.withOpacity(1),
            borderRadius: BorderRadiusStyle.roundedBorder20,
            border: Border.all(
              color: appTheme.blueGray10002,
              width: 0.5.h,
            ),
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.05),
                spreadRadius: 0.h,
                blurRadius: 10.h,
                offset: const Offset(
                  0,
                  4,
                ),
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 118.h,
                width: 118.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: 'library_cover_image_${libraryListItemModelObj.id}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: CustomImageView(
                          imagePath: libraryListItemModelObj.displayImage,
                          height: 130.h,
                          width: double.maxFinite,
                          radius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.zero,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    _buildQuestionsButton(context)
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      libraryListItemModelObj.displayTitle ?? "",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          libraryListItemModelObj.displayDate ?? "",
                          style: theme.textTheme.bodySmall,
                        ),
                        _buildStatusButton(context)
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: libraryListItemModelObj.publicIcon,
                          height: 16.h,
                          width: 14.h,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              libraryListItemModelObj.publicText ?? "",
                              style: CustomTextStyles.labelMediumBlack900,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //     width: double.maxFinite,
                  //     alignment: Alignment.topRight,
                  //     padding: EdgeInsets.only(right: 20.h),
                  //     child: CustomIconButton(
                  //       height: 32.h,
                  //       width: 40.h,
                  //       padding: EdgeInsets.all(2.h),
                  //       decoration: IconButtonStyleHelper.none,
                  //       child: CustomImageView(
                  //         imagePath: ImageConstant.imgDelete,
                  //       ),
                  //       onTap: () {
                  //         if (onDelete != null &&
                  //             libraryListItemModelObj.id != null) {
                  //           onDelete!(libraryListItemModelObj.id!);
                  //         }
                  //       },
                  //     ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(BuildContext context) {
    return CustomElevatedButton(
      height: 24.h,
      width: 55.h,
      text: libraryListItemModelObj.quizzflyStatus ?? "lbl_draft".tr,
      margin: EdgeInsets.only(left: 8.h),
      buttonStyle: CustomButtonStyles.fillErrorRadius5,
      buttonTextStyle: CustomTextStyles.labelSmallRed700,
      alignment: Alignment.center,
    );
  }

  /// Section Widget
  Widget _buildQuestionsButton(BuildContext context) {
    return CustomElevatedButton(
      height: 22.h,
      width: 45.h,
      text: "lbl_10_qs".tr,
      margin: EdgeInsets.only(
        right: 6.h,
        bottom: 10.h,
      ),
      buttonStyle: CustomButtonStyles.fillPrimaryRadius12,
      buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
      alignment: Alignment.bottomRight,
    );
  }
}
