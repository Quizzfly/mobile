import 'package:flutter/material.dart';
import 'widgets/list_group_item_widget.dart';
import 'widgets/notification_popup.dart';
import 'widgets/notification_popup_route.dart';
import 'widgets/show_dialog_widget.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../../../core/app_export.dart';
import '../../../../routes/navigation_args.dart';
import '../../../../widgets/custom_elevated_button.dart';
import 'bloc/home_bloc.dart';
import 'models/list_group_item_model.dart';
import 'models/home_initial_model.dart';
import 'models/recent_activities_grid_item_model.dart';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomElevatedButton(
                          width: 130.h,
                          text: "lbl_create_group".tr,
                          margin: EdgeInsets.only(left: 4.h),
                          gradientColors: const [
                            Color(0xFF37d2c0),
                            Color(0xFF7286ff)
                          ],
                          gradientBegin: Alignment.topLeft,
                          gradientEnd: Alignment.bottomRight,
                          buttonTextStyle:
                              CustomTextStyles.bodyMediumRobotoWhiteA700,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => ShowDialogWidget.builder(context),
                            );
                          },
                        ),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.h),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.notifications_none_rounded,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      final button = context.findRenderObject()
                                          as RenderBox;
                                      final overlay = Overlay.of(context)
                                          .context
                                          .findRenderObject() as RenderBox;
                                      final position = RelativeRect.fromRect(
                                        Rect.fromPoints(
                                          button.localToGlobal(Offset.zero,
                                              ancestor: overlay),
                                          button.localToGlobal(
                                              button.size
                                                  .bottomRight(Offset.zero),
                                              ancestor: overlay),
                                        ),
                                        Offset.zero & overlay.size,
                                      );

                                      // Show notification popup
                                      Navigator.of(context).push(
                                        NotificationPopupRoute(
                                          position: position,
                                          child: BlocProvider.value(
                                            value: context.read<HomeBloc>(),
                                            child: NotificationPopup(
                                              onReadAll: () {
                                                context.read<HomeBloc>().add(
                                                      MarkAllReadNotificationEvent(
                                                        onMarkAllNotificationSuccess:
                                                            () {},
                                                      ),
                                                    );
                                              },
                                              onSeeMore: () {
                                                Navigator.pop(context);
                                              },
                                              onNotificationTap:
                                                  (notification) {
                                                context.read<HomeBloc>().add(
                                                      MarkReadNotificationEvent(
                                                        id: notification
                                                            .notificationId,
                                                        onMarkNotificationSuccess:
                                                            () {
                                                          NavigatorService
                                                              .pushNamed(
                                                            AppRoutes
                                                                .detailPostScreen,
                                                            arguments: {
                                                              NavigationArgs
                                                                  .id: notification
                                                                          .notificationType ==
                                                                      "COMMENT"
                                                                  ? notification
                                                                      .postId
                                                                  : notification
                                                                      .id,
                                                              NavigationArgs
                                                                      .groupId:
                                                                  notification
                                                                      .targetId,
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // Unread count badge
                                if ((state.homeInitialModelObj?.unReadCount ??
                                        0) >
                                    0)
                                  Positioned(
                                    right: 15.h,
                                    top: 5.h,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Text(
                                        '${state.homeInitialModelObj?.unReadCount}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 42.h),
                    _buildJoinGameSection(context),
                    SizedBox(height: 56.h),
                    Padding(
                      padding: EdgeInsets.only(left: 12.h),
                      child: Text(
                        "msg_recent_activities".tr,
                        style: CustomTextStyles.titleMediumRobotoBlack900
                            .copyWith(fontSize: 18.h),
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
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(PrefUtils().getAvatar()),
            backgroundColor: Colors.transparent,
            // ignore: unnecessary_null_comparison
            child: PrefUtils().getAvatar() == null
                ? const Icon(Icons.person, size: 24)
                : null,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hello, ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appTheme.black900.withOpacity(0.7)),
                  ),
                  SizedBox(
                    width: 140.h,
                    child: Text(
                      PrefUtils().getName(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appTheme.black900.withOpacity(0.7),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const Text(
                    ' 👋',
                    style: TextStyle(fontSize: 23),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'How are you today?',
                style: TextStyle(
                    fontSize: 16,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Color(0xFF37d2c0), Color(0xFF7286ff)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
              ),
            ],
          ),
          SizedBox(width: 5.h),
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
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick access".tr,
            style: CustomTextStyles.bodyMediumRobotoFontGray90003,
          ),
          SizedBox(height: 20.h),
          BlocSelector<HomeBloc, HomeState, HomeInitialModel?>(
            selector: (state) => state.homeInitialModelObj,
            builder: (context, homeInitialModelObj) {
              if (homeInitialModelObj?.listGroupItemList.isEmpty ?? true) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: 50.h, bottom: 100.h, left: 30.h),
                  child: Column(
                    children: [
                      Image.asset(
                        ImageConstant.imgEmpty,
                        width: 100,
                        height: 100,
                      ),
                      const Text('No group found. Create one now!'),
                    ],
                  ),
                );
              }
              final topGroups =
                  homeInitialModelObj!.listGroupItemList.take(4).toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topGroups.length,
                itemBuilder: (context, index) {
                  ListGroupItemModel model = topGroups[index];
                  return ListGroupItemWidget(
                    model: model,
                    onDetailTap: () {
                      NavigatorService.pushNamed(
                        AppRoutes.communityScreen,
                        arguments: {
                          NavigationArgs.id: model.id,
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
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
          if (homeInitialModelObj!.recentActivitiesGridItemList.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 50.h, bottom: 100.h, left: 50.h),
              child: Column(
                children: [
                  Image.asset(
                    ImageConstant.imgEmpty,
                    width: 250,
                    height: 250,
                  ),
                  const Text('No quizzfly found. Create one now!'),
                ],
              ),
            );
          }
          ;
          final recentActivitiesGridItemLists =
              homeInitialModelObj.recentActivitiesGridItemList.take(6).toList();
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
              recentActivitiesGridItemLists.length,
              (index) {
                RecentActivitiesGridItemModel model =
                    recentActivitiesGridItemLists[index];
                return RecentActivitiesGridItemWidget(model, callDetail: () {
                  callDetail(context, index);
                });
              },
            ),
          );
        },
      ),
    );
  }

  callDetail(BuildContext context, int index) async {
    final refreshRequired = await NavigatorService.pushNamed(
      AppRoutes.quizzflyDetailScreen,
      arguments: {
        NavigationArgs.id:
            context.read<HomeBloc>().getRecentActivitiesResp.data?[index].id,
        NavigationArgs.heroTag:
            'library_cover_image_${context.read<HomeBloc>().getRecentActivitiesResp.data?[index].id}',
      },
    );

    // If returned value is true, refresh the library data
    if (refreshRequired == true) {
      context.read<HomeBloc>().add(
            CreateGetRecentActivitiesEvent(
              onGetRecentActivitiesError: () {},
              onGetRecentActivitiesSuccess: () {},
            ),
          );
    }
  }
}
