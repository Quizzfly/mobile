import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'bloc/waiting_room_bloc.dart';
import 'models/waiting_room_model.dart';

// ignore_for_file: must_be_immutable
class WaitingRoomScreen extends StatelessWidget {
  WaitingRoomScreen({Key? key})
      : super(
          key: key,
        );
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static Widget builder(BuildContext context) {
    return BlocProvider<WaitingRoomBloc>(
      create: (context) => WaitingRoomBloc(WaitingRoomState(
        inputNicknameModelObj: WaitingRoomModel(),
      ))
        ..add(WaitingRoomInitialEvent()),
      child: WaitingRoomScreen(),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgBackground1,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15.h, top: 12.h),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => NavigatorService.goBack(),
                    child: Container(
                      padding: EdgeInsets.all(10.h),
                      child: Image.asset(
                        ImageConstant.imgClose,
                        width: 24.h,
                        height: 24.h,
                        color: appTheme.whiteA700,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 150.h),
                  padding: EdgeInsets.symmetric(horizontal: 22.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [_buildContentColumn(context)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildContentColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 38.h),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: 52.h,
                    right: 46.h,
                  ),
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imageBackToSchool,
                        height: 116.h,
                        width: double.maxFinite,
                        radius: BorderRadius.circular(
                          10.h,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 18.h),
                      ),
                      SizedBox(height: 22.h),
                      Text(
                        "lbl_anh_dung".tr,
                        style: CustomTextStyles.graphikwhiteA700SemiBold,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "msg_you_re_in_see_your".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodyMediumRobotoWhiteA700
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
