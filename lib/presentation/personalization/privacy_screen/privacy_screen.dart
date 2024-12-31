import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_switch.dart';
import 'bloc/privacy_bloc.dart';
import 'models/privacy_model.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<PrivacyBloc>(
      create: (context) => PrivacyBloc(PrivacyState(
        privacyModelObj: const PrivacyModel(),
      ))
        ..add(PrivacyInitialEvent()),
      child: const PrivacyScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
              child: Column(
                children: [
                  _buildNotificationSettings(context),
                  SizedBox(height: 4.h),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                      boxShadow: [
                        BoxShadow(
                          color: appTheme.gray10001.withOpacity(0.8),
                          spreadRadius: 2.h,
                          blurRadius: 2.h,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 24.h),
                            child: Text(
                              "msg_privacy_and_marketing".tr,
                              style: CustomTextStyles
                                  .bodyMediumRobotoFontGray90003,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            color: appTheme.blueGray50,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                            border: Border.all(
                              color: appTheme.blueGray10001,
                              width: 1.h,
                            ),
                          ),
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 196.h,
                                margin: EdgeInsets.only(bottom: 16.h),
                                child: Text(
                                  "msg_i_have_read_and4".tr,
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodySmallGray90001
                                      .copyWith(
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              SizedBox(width: 22.h),
                              BlocSelector<PrivacyBloc, PrivacyState, bool?>(
                                selector: (state) => state.isSelectedSwitch4,
                                builder: (context, isSelectedSwitch4) {
                                  return CustomSwitch(
                                    alignment: Alignment.center,
                                    value: isSelectedSwitch4,
                                    onChange: (value) {
                                      context.read<PrivacyBloc>().add(
                                          ChangeSwitch4Event(value: value));
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                            border: Border.all(
                              color: appTheme.blueGray10001,
                              width: 1.h,
                            ),
                          ),
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200.h,
                                child: Text(
                                  "msg_i_want_to_receive".tr,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodySmallGray90001
                                      .copyWith(
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              SizedBox(width: 18.h),
                              BlocSelector<PrivacyBloc, PrivacyState, bool?>(
                                selector: (state) => state.isSelectedSwitch5,
                                builder: (context, isSelectedSwitch5) {
                                  return CustomSwitch(
                                    alignment: Alignment.center,
                                    value: isSelectedSwitch5,
                                    onChange: (value) {
                                      context.read<PrivacyBloc>().add(
                                          ChangeSwitch5Event(value: value));
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                            border: Border.all(
                              color: appTheme.blueGray10001,
                              width: 1.h,
                            ),
                          ),
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 206.h,
                                margin: EdgeInsets.only(bottom: 16.h),
                                child: Text(
                                  "msg_i_want_to_receive2".tr,
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodySmallGray90001
                                      .copyWith(
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.h),
                              BlocSelector<PrivacyBloc, PrivacyState, bool?>(
                                selector: (state) => state.isSelectedSwitch6,
                                builder: (context, isSelectedSwitch6) {
                                  return CustomSwitch(
                                    alignment: Alignment.center,
                                    value: isSelectedSwitch6,
                                    onChange: (value) {
                                      context.read<PrivacyBloc>().add(
                                          ChangeSwitch6Event(value: value));
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNotificationSettings(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder5,
        boxShadow: [
          BoxShadow(
            color: appTheme.gray10001.withOpacity(0.8),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              4,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: Text(
                "lbl_notification".tr,
                style: CustomTextStyles.bodyMediumRobotoFontGray90003,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.blueGray50,
            ),
          ),
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: Text(
                "msg_email_me_when_someone".tr,
                style: CustomTextStyles.bodyMediumRobotoFontGray90003,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
              border: Border.all(
                color: appTheme.blueGray10001,
                width: 1.h,
              ),
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "msg_shares_a_quizzfly".tr,
                    style: CustomTextStyles.bodySmallGray90001,
                  ),
                ),
                BlocSelector<PrivacyBloc, PrivacyState, bool?>(
                  selector: (state) => state.isSelectedSwitch,
                  builder: (context, isSelectedSwitch) {
                    return CustomSwitch(
                      value: isSelectedSwitch,
                      onChange: (value) {
                        context
                            .read<PrivacyBloc>()
                            .add(ChangeSwitchEvent(value: value));
                      },
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
              border: Border.all(
                color: appTheme.blueGray10001,
                width: 1.h,
              ),
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 188.h,
                  child: Text(
                    "msg_features_your_quizzfly".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallGray90001.copyWith(
                      height: 1.43,
                    ),
                  ),
                ),
                BlocSelector<PrivacyBloc, PrivacyState, bool?>(
                  selector: (state) => state.isSelectedSwitch1,
                  builder: (context, isSelectedSwitch1) {
                    return CustomSwitch(
                      value: isSelectedSwitch1,
                      onChange: (value) {
                        context
                            .read<PrivacyBloc>()
                            .add(ChangeSwitch1Event(value: value));
                      },
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
              border: Border.all(
                color: appTheme.blueGray10001,
                width: 1.h,
              ),
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 190.h,
                  child: Text(
                    "msg_shares_your_quizzfly".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallGray90001.copyWith(
                      height: 1.43,
                    ),
                  ),
                ),
                BlocSelector<PrivacyBloc, PrivacyState, bool?>(
                  selector: (state) => state.isSelectedSwitch2,
                  builder: (context, isSelectedSwitch2) {
                    return CustomSwitch(
                      value: isSelectedSwitch2,
                      onChange: (value) {
                        context
                            .read<PrivacyBloc>()
                            .add(ChangeSwitch2Event(value: value));
                      },
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
              border: Border.all(
                color: appTheme.blueGray10001,
                width: 1.h,
              ),
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "msg_favourites_your".tr,
                    style: CustomTextStyles.bodySmallGray90001,
                  ),
                ),
                BlocSelector<PrivacyBloc, PrivacyState, bool?>(
                  selector: (state) => state.isSelectedSwitch3,
                  builder: (context, isSelectedSwitch3) {
                    return CustomSwitch(
                      value: isSelectedSwitch3,
                      onChange: (value) {
                        context
                            .read<PrivacyBloc>()
                            .add(ChangeSwitch3Event(value: value));
                      },
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 14.h)
        ],
      ),
    );
  }
}
