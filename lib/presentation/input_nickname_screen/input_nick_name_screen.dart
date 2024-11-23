import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/routes/navigation_args.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/input_nickname_bloc.dart';
import 'models/input_nickname_model.dart';

// ignore_for_file: must_be_immutable
class InputNicknameScreen extends StatelessWidget {
  InputNicknameScreen({Key? key})
      : super(
          key: key,
        );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<InputNicknameBloc>(
      create: (context) => InputNicknameBloc(InputNicknameState(
        inputNicknameModelObj: InputNicknameModel(),
        roomPin: arg[NavigationArgs.roomPin],
      ))
        ..add(InputNicknameInitialEvent()),
      child: InputNicknameScreen(),
    );
  }

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
            key: _formKey,
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
                    children: [_buildNicknameInputSection(context)],
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
  Widget _buildNicknameInputSection(BuildContext context) {
    void showSnackBar(String message, bool isError) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? appTheme.red900 : Colors.green,
          duration: Duration(seconds: isError ? 3 : 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    return BlocConsumer<InputNicknameBloc, InputNicknameState>(
      listener: (context, state) {
        if (state.connectionStatus == ConnectionStatus.error) {
          showSnackBar(state.error ?? 'An error occurred', true);
        }
        if (state.connectionStatus == ConnectionStatus.joined) {
          showSnackBar("Joined room successfully", false);
          AppRoutes.navigateToWaitingRoomScreen(context);
        }
      },
      builder: (context, state) {
        return Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 28.h),
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Text(
                      "lbl_quizzfly".tr,
                      style: CustomTextStyles.graphikWhiteA700,
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.h,
                        vertical: 22.h,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.whiteA700,
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFormField(
                            controller: state.nameController,
                            hintText: "lbl_nick_name".tr,
                            textInputAction: TextInputAction.done,
                            contentPadding: EdgeInsets.all(12.h),
                            validator: (value) {
                              if (!isText(value)) {
                                return "err_msg_please_enter_valid_text".tr;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomElevatedButton(
                            height: 44.h,
                            text: "lbl_ok_go".tr,
                            buttonTextStyle:
                                CustomTextStyles.titleMediumWhiteA700Bold,
                            buttonStyle: CustomButtonStyles.fillPrimaryRadius12,
                            onPressed: () {
                              if (state.nameController?.text.isNotEmpty ??
                                  false) {
                                context.read<InputNicknameBloc>().add(
                                      JoinRoomEvent(
                                        pin: state.roomPin ?? '',
                                        name: state.nameController?.text ?? '',
                                      ),
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
