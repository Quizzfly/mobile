import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import 'bloc/change_password_bloc.dart';
import 'models/change_password_model.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ChangePasswordScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
      create: (context) => ChangePasswordBloc(ChangePasswordState(
        changePasswordModelObj: const ChangePasswordModel(),
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
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "lbl_change_password2".tr,
                      style: CustomTextStyles.bodyMediumRobotoFontGray90003,
                    ),
                    SizedBox(height: 20.h),
                    _buildOldPasswordSection(context),
                    SizedBox(height: 12.h),
                    _buildNewPasswordSection(context),
                    SizedBox(height: 12.h),
                    _buildConfirmPasswordSection(context),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      height: 44.h,
                      text: "lbl_save".tr,
                      buttonStyle: CustomButtonStyles.fillPrimaryRadius12,
                      buttonTextStyle: theme.textTheme.bodyLarge!,
                      onPressed: () => onTapSave(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOldPasswordSection(BuildContext context) {
    bool obscureText = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_old_password".tr,
              style: CustomTextStyles.bodyMediumRobotoGray90003,
            ),
            SizedBox(height: 4.h),
            BlocSelector<ChangePasswordBloc, ChangePasswordState,
                TextEditingController?>(
              selector: (state) => state.oldPasswordInputController,
              builder: (context, oldPasswordController) {
                return CustomTextFormField(
                  controller: oldPasswordController,
                  hintText: "msg_at_least_8_characters".tr,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.h,
                    vertical: 12.h,
                  ),
                  suffix: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "err_msg_please_enter_valid_password".tr;
                    } else if (value.length < 8) {
                      return "msg_at_least_8_characters".tr;
                    }
                    return null;
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildNewPasswordSection(BuildContext context) {
    bool obscureText = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_new_password2".tr,
              style: CustomTextStyles.bodyMediumRobotoGray90003,
            ),
            SizedBox(height: 4.h),
            BlocSelector<ChangePasswordBloc, ChangePasswordState,
                TextEditingController?>(
              selector: (state) => state.newPasswordInputController,
              builder: (context, newPasswordController) {
                return CustomTextFormField(
                  controller: newPasswordController,
                  hintText: "msg_at_least_8_characters".tr,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.h,
                    vertical: 12.h,
                  ),
                  suffix: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "err_msg_please_enter_valid_password".tr;
                    } else if (value.length < 8) {
                      return "msg_at_least_8_characters".tr;
                    }
                    return null;
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildConfirmPasswordSection(BuildContext context) {
    bool obscureText = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "msg_confirm_password".tr,
              style: CustomTextStyles.bodyMediumRobotoGray90003,
            ),
            SizedBox(height: 4.h),
            BlocSelector<ChangePasswordBloc, ChangePasswordState,
                TextEditingController?>(
              selector: (state) => state.confirmPasswordInputController,
              builder: (context, confirmPasswordController) {
                return CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: "msg_at_least_8_characters".tr,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.h,
                    vertical: 12.h,
                  ),
                  suffix: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "err_msg_please_enter_valid_password".tr;
                    } else if (value.length < 8) {
                      return "msg_at_least_8_characters".tr;
                    }
                    // Add validation to check if confirm password matches new password
                    final newPassword = context
                        .read<ChangePasswordBloc>()
                        .state
                        .newPasswordInputController
                        ?.text;
                    if (value != newPassword) {
                      return "err_msg_passwords_do_not_match".tr;
                    }
                    return null;
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void onTapSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ChangePasswordBloc>().add(
        CreateChangePasswordEvent(
          onCreateChangePasswordEventSuccess: () {
            _onChangePasswordEventSuccess(context);
          },
        ),
      );
    }
  }

  void _onChangePasswordEventSuccess(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'Change password succeed',
      ),
    );
  }
}
