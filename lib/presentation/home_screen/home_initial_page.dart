import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/widgets/custom_outlined_button.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/home_bloc.dart';
import 'models/grid_label_item_model.dart';
import 'models/home_initial_model.dart';
import 'models/recent_activities_grid_item_model.dart';
import 'widgets/grid_label_item_widget.dart';
import 'widgets/recent_activities_grid_item_widget.dart';

class HomeInitialPage extends StatefulWidget {
  const HomeInitialPage({super.key});
  @override
  HomeInitialPageState createState() => HomeInitialPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(HomeState(
        homeInitialModelObj: HomeInitialModel(),
      ))
        ..add(HomeInitialEvent()),
      child: const HomeInitialPage(),
    );
  }
}

class HomeInitialPageState extends State<HomeInitialPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700.withOpacity(1),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 20.h,
                  top: 20.h,
                  right: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: _greetingWidget(),
                    ),
                    SizedBox(height: 12.h),
                    Row(children: [
                      CustomElevatedButton(
                        width: 118.h,
                        text: "lbl_join_game".tr,
                        margin: EdgeInsets.only(left: 4.h),
                        buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
                        buttonTextStyle:
                            CustomTextStyles.bodyMediumRobotoWhiteA700,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomOutlinedButton(
                        width: 118.h,
                        text: "lbl_create_group".tr,
                        margin: EdgeInsets.only(left: 4.h),
                        buttonStyle: CustomButtonStyles.outlineDeepPurple20,
                        borderColor: appTheme.deppPurplePrimary,
                        buttonTextStyle:
                            CustomTextStyles.bodyMediumRobotoPrimary,
                      ),
                    ]),
                    SizedBox(height: 42.h),
                    _buildJoinGameSection(context),
                    SizedBox(height: 56.h),
                    Padding(
                      padding: EdgeInsets.only(left: 12.h),
                      child: Text(
                        "msg_recent_activities".tr,
                        style: CustomTextStyles.titleMediumRobotoBlack900,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    _buildRecentActivitiesGrid(context),
                    SizedBox(height: 22.h),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _greetingWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Hello, ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    PrefUtils().getName(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    ' 👋',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'How are you today?',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(PrefUtils().getAvatar()),
            backgroundColor: Colors.transparent,
            // ignore: unnecessary_null_comparison
            child: PrefUtils().getAvatar() == null
                ? const Icon(Icons.person, size: 24)
                : null,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildJoinGameSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700.withOpacity(1),
        borderRadius: BorderRadiusStyle.roundedBorder5,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.05),
            spreadRadius: 2.h,
            blurRadius: 10.h,
            offset: const Offset(
              0,
              4,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_project".tr,
            style: CustomTextStyles.bodyMediumRobotoFontGray90003,
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.only(
              left: 28.h,
              right: 32.h,
            ),
            child: BlocSelector<HomeBloc, HomeState, HomeInitialModel?>(
              selector: (state) => state.homeInitialModelObj,
              builder: (context, homeInitialModelObj) {
                return ResponsiveGridListBuilder(
                  minItemWidth: 1,
                  minItemsPerRow: 2,
                  maxItemsPerRow: 2,
                  horizontalGridSpacing: 70.h,
                  verticalGridSpacing: 70.h,
                  builder: (context, items) => ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: items,
                  ),
                  gridItems: List.generate(
                    homeInitialModelObj?.gridLabelItemList.length ?? 0,
                    (index) {
                      GridLabelItemModel model =
                          homeInitialModelObj?.gridLabelItemList[index] ??
                              GridLabelItemModel();
                      return GridLabelItemWidget(
                        model,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 34.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentActivitiesGrid(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: BlocSelector<HomeBloc, HomeState, HomeInitialModel?>(
        selector: (state) => state.homeInitialModelObj,
        builder: (context, homeInitialModelObj) {
          return ResponsiveGridListBuilder(
            minItemWidth: 1,
            minItemsPerRow: 2,
            maxItemsPerRow: 2,
            horizontalGridSpacing: 14.h,
            verticalGridSpacing: 14.h,
            builder: (context, items) => ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: items,
            ),
            gridItems: List.generate(
              homeInitialModelObj?.recentActivitiesGridItemList.length ?? 0,
              (index) {
                RecentActivitiesGridItemModel model =
                    homeInitialModelObj?.recentActivitiesGridItemList[index] ??
                        RecentActivitiesGridItemModel();
                return RecentActivitiesGridItemWidget(
                  model,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
