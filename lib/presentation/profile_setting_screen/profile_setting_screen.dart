import 'package:flutter/material.dart';
import '../../../presentation/profile_setting_screen/bloc/profile_setting_bloc.dart';
import '../../../presentation/profile_setting_screen/models/profile_setting_model.dart';
import '../../presentation/edit_profile_screen/edit_profile_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../change_password_screen/change_password_screen.dart';
import "../privacy_screen/privacy_screen.dart";

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);
  @override
  ProfileSettingScreenState createState() => ProfileSettingScreenState();
  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileSettingBloc>(
      create: (context) => ProfileSettingBloc(ProfileSettingState(
        profileSettingModelObj: ProfileSettingModel(),
      ))
        ..add(ProfileSettingInitialEvent()),
      child: ProfileSettingScreen(),
    );
  }
}

class ProfileSettingScreenState extends State<ProfileSettingScreen>
    with TickerProviderStateMixin {
  late TabController tabViewController;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    tabViewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildProfileStack(context),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: tabViewController,
                    children: [
                      EditProfileScreen.builder(context),
                      PrivacyScreen.builder(context),
                      ChangePasswordScreen.builder(context),
                      ChangePasswordScreen.builder(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStack(BuildContext context) {
    return SizedBox(
      height: 112.h,
      width: 426.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(   
              height: 112.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                border: Border(
                  bottom: BorderSide(
                    color: appTheme.indigo50,
                    width: 4.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(
                  title: AppbarTitle(
                    text: "msg_profile_settings".tr,
                    margin: EdgeInsets.only(left: 16.h),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.maxFinite,
                  child: TabBar(
                    controller: tabViewController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: appTheme.blueGray900,
                    labelStyle: TextStyle(
                      fontSize: 14.fSize,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelColor: appTheme.blueGray500,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14.fSize,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                        width: 4.h,
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.only(left : 6.0,right: 6.0),
                        child: Tab(text: "lbl_top_bar_edit".tr),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left : 6.0,right: 6.0),
                        child: Tab(text: "lbl_top_bar_privacy".tr),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left : 6.0,right: 6.0),
                        child: Tab(text: "lbl_top_bar_change_password".tr),
                      ),
                      Tab(text: "lbl_billing".tr),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: appTheme.indigo50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

