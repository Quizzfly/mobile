import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../authentication/change_password_screen/change_password_screen.dart';
import '../edit_profile_screen/edit_profile_screen.dart';
import "../privacy_screen/privacy_screen.dart";
import 'bloc/profile_setting_bloc.dart';
import 'models/profile_setting_model.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});
  @override
  ProfileSettingScreenState createState() => ProfileSettingScreenState();
  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileSettingBloc>(
      create: (context) => ProfileSettingBloc(ProfileSettingState(
        profileSettingModelObj: const ProfileSettingModel(),
      ))
        ..add(ProfileSettingInitialEvent()),
      child: const ProfileSettingScreen(),
    );
  }
}

class ProfileSettingScreenState extends State<ProfileSettingScreen>
    with TickerProviderStateMixin {
  late TabController tabViewController;
  @override
  void initState() {
    super.initState();
    tabViewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: EdgeInsets.only(left: 5.h, top: 16.h),
            color: appTheme.whiteA700,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 25.h,
              leading: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: const Icon(Icons.person)),
              titleSpacing: 25.h,
              title: const Text(
                'Profile Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: 414.h,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildProfileTab(context),
              Expanded(
                child: TabBarView(
                  controller: tabViewController,
                  children: [
                    EditProfileScreen.builder(context),
                    PrivacyScreen.builder(context),
                    ChangePasswordScreen.builder(context),
                    ChangePasswordScreen.builder(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: double.maxFinite,
      child: TabBar(
        controller: tabViewController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicatorColor: appTheme.deppPurplePrimary,
        tabAlignment: TabAlignment.start,
        labelColor: appTheme.deppPurplePrimary,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: "lbl_top_bar_edit".tr),
          Tab(text: "lbl_top_bar_privacy".tr),
          Tab(text: "lbl_top_bar_change_password".tr),
          Tab(text: "lbl_billing".tr),
        ],
      ),
    );
  }
}
