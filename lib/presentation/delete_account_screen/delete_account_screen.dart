import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/delete_account_bloc.dart';
import 'models/delete_account_model.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<DeleteAccountBloc>(
      create: (context) => DeleteAccountBloc(DeleteAccountState(
        deleteAccountModelObj: DeleteAccountModel(),
      ))
        ..add(DeleteAccountInitialEvent()),
      child: const DeleteAccountScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 44.h),
          child: SingleChildScrollView(
            child: Container(
              height: 654.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 18.h),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildConfirmationSection(context),
                  SizedBox(height: 40.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 8.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                      boxShadow: [
                        BoxShadow(
                          color: appTheme.gray10001,
                          spreadRadius: 2.h,
                          blurRadius: 2.h,
                          offset: Offset(
                            0,
                            4,
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildUserInfoRow(context),
                        SizedBox(height: 44.h),
                        Text(
                          "msg_we_d_appreciate".tr,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.bodyMediumBlack900_1.copyWith(
                            height: 1.43,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _buildRequestDeleteRow(context),
                        SizedBox(height: 12.h),
                        _buildInputSection(context),
                        SizedBox(height: 44.h),
                        _buildActionButtonsRow(context)
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
  Widget _buildConfirmationSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          Text(
            "msg_are_you_sure_you_d".tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.headlineSmallSFProRoundedGray90003,
          ),
          SizedBox(height: 28.h),
          Text(
            "msg_we_re_sorry_to_see".tr,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.bodyMediumBlack900_1,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserInfoRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imageAvatar,
            height: 70.h,
            width: 70.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "lbl_anh_dung".tr,
              style: CustomTextStyles.titleMediumRobotoBlack900,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRequestButton(BuildContext context) {
    return CustomElevatedButton(
      width: 86.h,
      text: "lbl_request".tr,
      buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
      buttonTextStyle: CustomTextStyles.labelLargeWhiteA700,
      onPressed: () {
        callApi(context);
      },
      alignment: Alignment.center,
    );
  }

  /// Section Widget
  Widget _buildRequestDeleteRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.h,
        vertical: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              "msg_request_delete_account".tr,
              style: CustomTextStyles.titleMediumRobotoBlack900,
            ),
          ),
          SizedBox(width: 20.h),
          _buildRequestButton(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCodeInputField(BuildContext context) {
    return BlocSelector<DeleteAccountBloc, DeleteAccountState,
        TextEditingController?>(
      selector: (state) => state.codeInputFieldController,
      builder: (context, codeInputFieldController) {
        return CustomTextFormField(
          controller: codeInputFieldController,
          textInputAction: TextInputAction.done,
          contentPadding: EdgeInsets.all(12.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL81,
          fillcolor: appTheme.gray10002,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildInputSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_code".tr,
            style: CustomTextStyles.bodyMediumBlack900_1,
          ),
          SizedBox(height: 6.h),
          _buildCodeInputField(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCancelButton(BuildContext context) {
    return CustomElevatedButton(
      width: 86.h,
      text: "lbl_cancel".tr,
      margin: EdgeInsets.only(top: 8.h),
      buttonStyle: CustomButtonStyles.fillGray,
      buttonTextStyle: CustomTextStyles.labelLargeGray500,
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      width: 104.h,
      text: "lbl_delete_account".tr,
      buttonStyle: CustomButtonStyles.fillRedRadius20,
      buttonTextStyle: CustomTextStyles.labelLargeWhiteA700,
      onPressed: () {
        callAPIVerifyDelete(context);
      },
    );
  }

  /// Section Widget
  Widget _buildActionButtonsRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 44.h,
        vertical: 2.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCancelButton(context),
          SizedBox(width: 22.h),
          _buildSaveButton(context)
        ],
      ),
    );
  }

  callApi(BuildContext context) {
    context.read<DeleteAccountBloc>().add(
      CreateRequestDeleteEvent(
        onCreateRequestDeleteEventSuccess: () {
          _onRequestDeleteUserEventSuccess(context);
        },
      ),
    );
  }

  /// Displays a toast message using the Fluttertoast library.
  void _onRequestDeleteUserEventSuccess(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Code will expire in 5 minutes",
    );
  }

  callAPIVerifyDelete(BuildContext context) {
    context.read<DeleteAccountBloc>().add(
      DeleteVerifyDeleteEvent(
        onDeleteVerifyDeleteEventSuccess: () {
          _onVerifyDeleteUserEventSuccess(context);
        },
      ),
    );
  }

  /// Calls the http://103.161.96.76:3000/api/v1/auth/logout API and tr
  ///
// The [ BuildContext] parameter represents current [BuildContext]
  void _onVerifyDeleteUserEventSuccess(BuildContext context) {
    context.read<DeleteAccountBloc>().add(
      CreateLogoutEvent(
        onCreateLogoutEventSuccess: () {
          _onLogoutPostEventSuccess(context);
        },
      ),
    );
  }

  /// Navigates to the loginScreen when the action is triggered.
  void _onLogoutPostEventSuccess(BuildContext context) {
    PrefUtils().clearPreferencesData();

    NavigatorService.pushNamed(
      AppRoutes.loginScreen,
    );
  }
}
