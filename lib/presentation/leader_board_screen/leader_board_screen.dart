import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import 'bloc/leader_board_bloc.dart';
import 'models/leader_board_model.dart';
import 'models/users_rank_list_item_model.dart';
import 'widgets/users_rank_list_item_widget.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<LeaderBoardBloc>(
      create: (context) => LeaderBoardBloc(LeaderBoardState(
        leaderBoardModelObj: LeaderBoardModel(),
      ))
        ..add(LeaderBoardInitialEvent()),
      child: LeaderBoardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 10.h,
                top: 4.h,
                right: 8.h,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 890.h,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [_buildPodiumSection(context)],
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 10.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [_buildUsersRankList(context)],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 20.h,
      height: 50.h,
      padding: EdgeInsets.only(left: 25.h),
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgTurnBack,
        color: appTheme.whiteA700,
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_leader_board".tr,
        textColor: appTheme.whiteA700,
        padding: EdgeInsets.only(right: 20.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildUsersRankList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.gray10001,
        borderRadius: BorderRadius.circular(12.h),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      child: BlocSelector<LeaderBoardBloc, LeaderBoardState, LeaderBoardModel?>(
        selector: (state) => state.leaderBoardModelObj,
        builder: (context, leaderBoardModelObj) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.h,
              );
            },
            itemCount: leaderBoardModelObj?.usersRankListItem.length ?? 0,
            itemBuilder: (context, index) {
              UsersRankListItemModel model =
                  leaderBoardModelObj?.usersRankListItem[index] ??
                      UsersRankListItemModel();
              return UsersRankListItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildPodiumSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 100.h,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 25.h),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CustomIconButton(
                            height: 56.h,
                            width: 56.h,
                            decoration: IconButtonStyleHelper.fillTeal,
                            child: CustomImageView(
                              imagePath: ImageConstant.imageAvatar,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 50.h,
                              margin: EdgeInsets.only(right: 6.h),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgSilver,
                                    height: 50.h,
                                    width: double.maxFinite,
                                    radius: BorderRadius.circular(
                                      4.h,
                                    ),
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgSilver,
                                    height: 50.h,
                                    width: 50.h,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.h),
                        child: Text(
                          "lbl_alena_donin".tr,
                          style: CustomTextStyles.titleMediumWhiteA700,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomElevatedButton(
                      height: 34.h,
                      width: 56.h,
                      text: "1890".tr,
                      buttonStyle: CustomButtonStyles.fillDeepPurpleTL12,
                      buttonTextStyle: CustomTextStyles.labelLargeWhiteA700,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.maxFinite,
                      height: 200.h,
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            ImageConstant.imgRank2,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 100.h,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 26.h),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CustomIconButton(
                            height: 56.h,
                            width: 56.h,
                            decoration: IconButtonStyleHelper.fillTeal,
                            child: CustomImageView(
                              imagePath: ImageConstant.imageAvatar,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 50.h,
                              margin: EdgeInsets.only(right: 6.h),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgGold,
                                    height: 50.h,
                                    width: double.maxFinite,
                                    radius: BorderRadius.circular(
                                      4.h,
                                    ),
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgGold,
                                    height: 50.h,
                                    width: 50.h,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "lbl_davis_curtis".tr,
                      style: CustomTextStyles.titleMediumWhiteA700,
                    ),
                    SizedBox(height: 6.h),
                    CustomElevatedButton(
                      height: 34.h,
                      text: "1894".tr,
                      margin: EdgeInsets.only(
                        left: 24.h,
                        right: 26.h,
                      ),
                      buttonStyle: CustomButtonStyles.fillDeepPurpleTL12,
                      buttonTextStyle: CustomTextStyles.labelLargeWhiteA700,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.maxFinite,
                      height: 250.h,
                      padding: EdgeInsets.symmetric(vertical: 26.h),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            ImageConstant.imgRank1,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 100.h,
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(horizontal: 26.h),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CustomIconButton(
                              height: 56.h,
                              width: 56.h,
                              decoration: IconButtonStyleHelper.fillTeal,
                              child: CustomImageView(
                                imagePath: ImageConstant.imageAvatar,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 50.h,
                                margin: EdgeInsets.only(right: 6.h),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgBronze,
                                      height: 50.h,
                                      width: double.maxFinite,
                                      radius: BorderRadius.circular(
                                        4.h,
                                      ),
                                    ),
                                    CustomImageView(
                                      imagePath: ImageConstant.imgBronze,
                                      height: 50.h,
                                      width: 50.h,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "lbl_craig_gouse".tr,
                        style: CustomTextStyles.titleMediumWhiteA700,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomElevatedButton(
                        height: 34.h,
                        width: 56.h,
                        text: "1065".tr,
                        margin: EdgeInsets.only(right: 20.h),
                        buttonStyle: CustomButtonStyles.fillDeepPurpleTL12,
                        buttonTextStyle: CustomTextStyles.labelLargeWhiteA700,
                        alignment: Alignment.centerRight,
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.maxFinite,
                        height: 170.h,
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImageConstant.imgRank3,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
