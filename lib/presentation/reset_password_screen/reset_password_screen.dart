import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
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
        ..add(ResetPasswordInitialEvent()),
      child: ResetPasswordScreen(),
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
              padding: EdgeInsets.only(
                left: 24.h,
                top: 20.h,
                right: 24.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 2.h),
                  CustomImageView(
                    imagePath: ImageConstant.imageLogo,
                    height: 180.h,
                    width: double.maxFinite,
                    radius: BorderRadius.circular(
                      20.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildWelcomeSection(context),
                  SizedBox(height: 18.h),
                  _buildNewPasswordInputSection(context),
                  SizedBox(height: 14.h),
                  _buildConfirmNewPasswordInputSection(context),
                  SizedBox(height: 14.h),
                  CustomElevatedButton(
                    height: 44.h,
                    text: "lbl_submit".tr,
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle: theme.textTheme.bodyLarge!,
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "title_reset_password".tr,
                  style: CustomTextStyles.headlineSmallSFProRoundedGray90003,
                ),
                WidgetSpan(
                  child:
                      SizedBox(width: 10), // Add a SizedBox to simulate padding
                ),
                TextSpan(
                  text: "lbl".tr,
                  style: CustomTextStyles
                      .headlineSmallSFProRoundedGray90003Regular,
                )
              ],
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 14.h),
          Text(
            "lbl_enter_your_password_reset".tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                CustomTextStyles.bodyMediumSFProDisplayErrorContainer.copyWith(
              height: 1.60,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNewPasswordInputSection(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool _obscureText = true; // Variable to track password visibility

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: double.maxFinite,
          child: Form(
            key: _formKey,
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // Enable auto-validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_new_password".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 4.h),
                BlocSelector<ResetPasswordBloc, ResetPasswordState,
                    TextEditingController?>(
                  selector: (state) => state.newPasswordController,
                  builder: (context, newPasswordController) {
                    return CustomTextFormField(
                      controller: newPasswordController,
                      hintText: "msg_at_least_8_characters".tr,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText:
                          _obscureText, // Use the boolean to toggle visibility
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.h,
                        vertical: 12.h,
                      ),
                      suffix: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          // Toggle password visibility
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "err_msg_please_enter_valid_password"
                              .tr; // Validate null
                        } else if (value.length < 8) {
                          return "msg_at_least_8_characters"
                              .tr; // Validate length < 8
                        }
                        return null; // Return null if validation passes
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmNewPasswordInputSection(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool _obscureText = true; // Variable to track password visibility

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: double.maxFinite,
          child: Form(
            key: _formKey,
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // Enable auto-validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_confirm_password".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 4.h),
                BlocSelector<ResetPasswordBloc, ResetPasswordState,
                    TextEditingController?>(
                  selector: (state) => state.confirmNewPasswordController,
                  builder: (context, confirmNewPasswordController) {
                    return CustomTextFormField(
                      controller: confirmNewPasswordController,
                      hintText: "msg_at_least_8_characters".tr,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText:
                          _obscureText, // Use the boolean to toggle visibility
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.h,
                        vertical: 12.h,
                      ),
                      suffix: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          // Toggle password visibility
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "err_msg_please_enter_valid_password"
                              .tr; // Validate null
                        } else if (value !=
                            context
                                .read<ResetPasswordBloc>()
                                .state
                                .newPasswordController
                                ?.text) {
                          return "err_msg_passwords_do_not_match"
                              .tr; // Validation to check if passwords match
                        }
                        return null; // Return null if validation passes
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
