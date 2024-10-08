import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/change_password_bloc.dart';
import 'models/change_password_model.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key})
      : super(
          key: key,
        );
  static Widget builder(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
      create: (context) => ChangePasswordBloc(ChangePasswordState(
        changePasswordModelObj: ChangePasswordModel(),
      ))
        ..add(ChangePasswordInitialEvent()),
      child: ChangePasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 22.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildChangePasswordForm(context)],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOldPasswordInput(BuildContext context) {
    return BlocSelector<ChangePasswordBloc, ChangePasswordState,
        TextEditingController?>(
      selector: (state) => state.oldPasswordInputController,
      builder: (context, oldPasswordInputController) {
        return CustomTextFormField(
          controller: oldPasswordInputController,
          hintText: "msg_at_least_8_characters".tr,
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
          contentPadding: EdgeInsets.all(12.h),
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password";
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildNewPasswordInput(BuildContext context) {
    return BlocSelector<ChangePasswordBloc, ChangePasswordState,
        TextEditingController?>(
      selector: (state) => state.newPasswordInputController,
      builder: (context, newPasswordInputController) {
        return CustomTextFormField(
          controller: newPasswordInputController,
          hintText: "msg_at_least_8_characters".tr,
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
          contentPadding: EdgeInsets.all(12.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL82,
          fillcolor: appTheme.gray10002,
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password";
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildConfirmPasswordInput(BuildContext context) {
    return BlocSelector<ChangePasswordBloc, ChangePasswordState,
        TextEditingController?>(
      selector: (state) => state.confirmPasswordInputController,
      builder: (context, confirmPasswordInputController) {
        return CustomTextFormField(
          controller: confirmPasswordInputController,
          hintText: "msg_at_least_8_characters".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
          contentPadding: EdgeInsets.all(12.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL82,
          fillcolor: appTheme.gray10002,
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password";
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      height: 30.h,
      width: 66.h,
      text: "lbl_save".tr,
      buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
      buttonStyle: CustomButtonStyles.fillPrimary,
    );
  }

  /// Section Widget
  Widget _buildChangePasswordForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder5,
        boxShadow: [
          BoxShadow(
              color: appTheme.black900.withOpacity(0.1),
              spreadRadius: 2.h,
              blurRadius: 2.h,
              offset: Offset(
                0,
                4,
              )),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: Text(
                "lbl_change_password2".tr,
                style: CustomTextStyles.bodyMediumRobotoFontGray90003,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.blueGray50,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_old_password".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 6.h),
                _buildOldPasswordInput(context)
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_new_password2".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 6.h),
                _buildNewPasswordInput(context)
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "msg_confirm_password".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 6.h),
                _buildConfirmPasswordInput(context)
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _buildSaveButton(context)
        ],
      ),
    );
  }
}
