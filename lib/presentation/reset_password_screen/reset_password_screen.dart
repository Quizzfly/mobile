import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/reset_password_bloc.dart';
import 'models/reset_password_model.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key})
      : super(
          key: key,
        );
  static Widget builder(BuildContext context) {
    return BlocProvider<ResetPasswordBloc>(
      create: (context) => ResetPasswordBloc(ResetPasswordState(
        resetPasswordModelObj: ResetPasswordModel(),
      ))
        ..add(ResetPasswordEvent()),
      child: ResetPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 22.h,
                top: 100.h,
                right: 22.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [_buildPasswordResetSection(context)],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildPasswordResetSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imageTick,
            height: 136.h,
            width: 142.h,
          ),
          SizedBox(height: 42.h),
          Text(
            "msg_password_reset_link".tr,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 44.h),
          Text(
            "msg_an_email_with_password".tr,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.bodyMediumInterBluegray800.copyWith(
              height: 1.60,
            ),
          ),
          SizedBox(height: 22.h),
          CustomElevatedButton(
            text: "lbl_back_to_log_in".tr,
          )
        ],
      ),
    );
  }
}
