import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../library_screen/models/library_list_item_model.dart';
// ignore_for_file: must_be_immutable
class LibraryListItemWidget extends StatelessWidget {
  LibraryListItemWidget(this.libraryListItemModelObj, {Key? key, this.callDetail})
      : super(key: key);

  LibraryListItemModel libraryListItemModelObj;

  VoidCallback? callDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callDetail?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder8,
          border: Border.all(
            color: appTheme.blueGray10002,
            width: 0.5.h,
          ),
        ),
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
                    CustomImageView(
                      imagePath: libraryListItemModelObj.displayImage,
                      height: 120.h,
                      width: double.maxFinite,
                      radius: BorderRadius.circular(5.h),
                      fit: BoxFit.cover,
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
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildHostLiveButton(context),
                        _buildPlaySoloButton(context)
                      ],
                    ),
                  )
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

  /// Section Widget
  Widget _buildHostLiveButton(BuildContext context) {
    return CustomElevatedButton(
      height: 30.h,
      width: 50.h,
      text: "lbl_host_live".tr,
      buttonStyle: CustomButtonStyles.fillPrimaryRadius12,
      buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
    );
  }

  /// Section Widget
  Widget _buildPlaySoloButton(BuildContext context) {
    return CustomElevatedButton(
      height: 30.h,
      width: 50.h,
      text: "lbl_play_solo".tr,
      margin: EdgeInsets.only(left: 10.h),
      buttonStyle: CustomButtonStyles.fillGray,
      buttonTextStyle: CustomTextStyles.titleMediumGray500,
    );
  }
}
