import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/routes/navigation_args.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/quizzfly_detail_bloc.dart';
import 'models/overview_quizzfly_item_model.dart';
import 'models/quiz_list_item_model.dart';
import 'models/quizzfly_detail_model.dart';
import 'widgets/overview_list_item_widget.dart';
import 'widgets/quiz_list_item_widget.dart';

class QuizzflyDetailScreen extends StatelessWidget {
  const QuizzflyDetailScreen({super.key});
  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<QuizzflyDetailBloc>(
      create: (context) => QuizzflyDetailBloc(QuizzflyDetailState(
        quizzflyDetailModelObj: QuizzflyDetailModel(),
        id: arg[NavigationArgs.id],
      ))
        ..add(QuizzflyDetailInitialEvent()),
      child: const QuizzflyDetailScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 16.h,
                top: 26.h,
                right: 12.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: _buildAppBar(context),
                  ),
                  SizedBox(height: 24.h),
                  BlocSelector<QuizzflyDetailBloc, QuizzflyDetailState,
                      QuizzflyDetailModel?>(
                    selector: (state) => state.quizzflyDetailModelObj,
                    builder: (context, model) {
                      return Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(right: 4.h),
                        child: Column(
                          children: [
                            // Cover Image
                            CustomImageView(
                              imagePath:
                                  model?.coverImage ?? ImageConstant.imageLogo,
                              height: 210.h,
                              width: double.maxFinite,
                              radius: BorderRadius.circular(15.h),
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 14.h),

                            // Title
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                model?.title ?? "msg_statistics_math".tr,
                                style: CustomTextStyles
                                    .headlineSmallSFProRoundedGray90003,
                              ),
                            ),
                            SizedBox(height: 16.h),

                            _buildStatisticsSection(context),
                            SizedBox(height: 12.h),

                            // User Profile Section
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 270.h,
                                margin: EdgeInsets.only(left: 4.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: CustomImageView(
                                        imagePath: model?.avatar ??
                                            ImageConstant.imageAvatar,
                                        height: 60.h,
                                        width: 60.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 14.h),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 4.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model?.name ??
                                                    "lbl_anh_dung".tr,
                                                style: CustomTextStyles
                                                    .titleMediumRobotoBlack900,
                                              ),
                                              SizedBox(height: 8.h),
                                              Text(
                                                model?.username ??
                                                    "lbl_dung0158234".tr,
                                                style: CustomTextStyles
                                                    .bodyMediumBlack900_1,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _buildDescriptionSection(context),
                            SizedBox(height: 8.h),

                            // Question Count Section
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 6.h),
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "lbl_question".tr,
                                      style: CustomTextStyles
                                          .titleMediumRobotoBlack900,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.h),
                                      child: Text(
                                        "(${model?.quizCount})",
                                        style: CustomTextStyles
                                            .titleMediumRobotoBlack900,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            _buildQuizList(context)
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStatisticsSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.blueGray100,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 70.h,
            // padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: BlocSelector<QuizzflyDetailBloc, QuizzflyDetailState,
                QuizzflyDetailModel?>(
              selector: (state) => state.quizzflyDetailModelObj,
              builder: (context, quizzflyDetailModelObj) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return VerticalDivider(
                      width: 1.h,
                      thickness: 1.h,
                      color: appTheme.blueGray100,
                    );
                  },
                  itemCount:
                      quizzflyDetailModelObj?.overviewQuizzflyItemList.length ??
                          0,
                  itemBuilder: (context, index) {
                    OverviewQuizzflyItemModel model = quizzflyDetailModelObj
                            ?.overviewQuizzflyItemList[index] ??
                        OverviewQuizzflyItemModel();
                    return OverviewListItemWidget(model);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.blueGray100,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10.h,
        right: 16.h,
      ),
      width: double.maxFinite,
      child: CustomAppBar(
        height: 22.h,
        leadingWidth: 28.h,
        leading: AppBarLeadingImage(
          imagePath: ImageConstant.imgClose,
          onTap: () => Navigator.pop(context,true),
        ),
        actions: [
          AppBarLeadingImage(
            imagePath: ImageConstant.imgSetting,
            margin: EdgeInsets.only(right: 16.h),
            onTap: () {
              navigateToQuizzfflySetting(context);
            },
          ),
          AppBarLeadingImage(
            imagePath: ImageConstant.imgHeart,
            margin: EdgeInsets.only(right: 16.h),
            onTap: () {
              // Handle favorite action
            },
          ),
          AppBarLeadingImage(
            imagePath: ImageConstant.imgMore,
            margin: EdgeInsets.only(right: 2.h),
            onTap: () {},
          ),
        ],
        styleType: Style.bgFillonErrorContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildDescriptionSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 6.h,
        right: 6.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_description".tr,
            style: CustomTextStyles.titleMediumRobotoBlack900,
          ),
          SizedBox(height: 6.h),
          BlocSelector<QuizzflyDetailBloc, QuizzflyDetailState, String?>(
            selector: (state) => state.quizzflyDetailModelObj!.description,
            builder: (context, description) {
              return Text(
                description ?? "",
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodyLargeBluegray900,
              );
            },
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildQuizList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: BlocSelector<QuizzflyDetailBloc, QuizzflyDetailState,
          QuizzflyDetailModel?>(
        selector: (state) => state.quizzflyDetailModelObj,
        builder: (context, quizzflyDetailModelObj) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount: quizzflyDetailModelObj?.quizListItemList.length ?? 0,
            itemBuilder: (context, index) {
              QuizListItemModel model =
                  quizzflyDetailModelObj?.quizListItemList[index] ??
                      QuizListItemModel();
              return QuizListItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }

  

  /// Navigates to the popupSettingScreen when the action is triggered.
  navigateToQuizzfflySetting(BuildContext context) async {
    final result =
        await NavigatorService.pushNamed(AppRoutes.quizzflySetting, arguments: {
      NavigationArgs.id:
          context.read<QuizzflyDetailBloc>().getDetailQuizzflyResp.data?.id,
      NavigationArgs.isPublic: context
          .read<QuizzflyDetailBloc>()
          .getDetailQuizzflyResp
          .data
          ?.isPublic,
      NavigationArgs.title:
          context.read<QuizzflyDetailBloc>().getDetailQuizzflyResp.data?.title,
      NavigationArgs.description: context
          .read<QuizzflyDetailBloc>()
          .getDetailQuizzflyResp
          .data
          ?.description,
      NavigationArgs.coverImage: context
          .read<QuizzflyDetailBloc>()
          .getDetailQuizzflyResp
          .data
          ?.coverImage
    });

    if (result == true) {
      context.read<QuizzflyDetailBloc>().add(QuizzflyDetailInitialEvent());
    }
  }
}
