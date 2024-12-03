import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/forgot_password_bloc.dart';
import 'models/forgot_password_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
      create: (context) => ForgotPasswordBloc(ForgotPasswordState(
        forgotPasswordModelObj: const ForgotPasswordModel(),
      ))
        ..add(ForgotPasswordInitialEvent()),
      child: ForgotPasswordScreen(),
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
              child: Form(
                key: _formKey, // Use the class-level _formKey here
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    _buildEmailInputSection(context),
                    SizedBox(height: 14.h),
                    CustomElevatedButton(
                      height: 44.h,
                      text: "lbl_submit".tr,
                      buttonStyle: CustomButtonStyles.fillPrimaryRadius12,
                      buttonTextStyle: theme.textTheme.bodyLarge!,
                      onPressed: () {
                        onTapSubmit(context);
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
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
                  text: "title_forgot_password".tr,
                  style: CustomTextStyles.headlineSmallSFProRoundedGray90003,
                ),
                const WidgetSpan(
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
            "lbl_enter_your_email_get_reset".tr,
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

  /// Section Widget
  Widget _buildEmailInputSection(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SizedBox(
        width: double.maxFinite,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "lbl_email".tr,
                      style: CustomTextStyles.bodyMediumRobotoGray90003,
                    )
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              BlocSelector<ForgotPasswordBloc, ForgotPasswordState,
                  TextEditingController?>(
                selector: (state) => state.emailController,
                builder: (context, emailController) {
                  return CustomTextFormField(
                    controller: emailController,
                    hintText: "msg_example_email_com".tr,
                    textInputType: TextInputType.emailAddress,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.h,
                      vertical: 12.h,
                    ),
                    validator: (value) {
                      if (value == null ||
                          (!isValidEmail(value, isRequired: true))) {
                        return "err_msg_please_enter_valid_email".tr;
                      }
                      return null;
                    },
                  );
                },
              )
            ],
          ),
        ));
  }

  onTapSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ForgotPasswordBloc>().add(
            CreateForgotPasswordEvent(
              onCreateForgotPasswordEventSuccess: () {
                onPostForgotPasswordEventSuccess(context);
              },
              onCreateForgotPasswordEventError: () {
                onPostForgotPasswordEventError(context);
              },
            ),
          );
    }
  }

  /// Navigates to the notificationScreen when the action is triggered.
  void onPostForgotPasswordEventSuccess(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.resetPassWordScreen,
    );
  }

  /// Displays a toast message using the Fluttertoast library.
  void onPostForgotPasswordEventError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Email does not exist',
      ),
    );
  }
}
