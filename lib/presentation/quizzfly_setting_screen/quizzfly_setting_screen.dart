import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_export.dart';
import '../../routes/navigation_args.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/quizzfly_setting_bloc.dart';
import 'models/quizzfly_setting_model.dart';
import 'dart:io';

class QuizzflySettingScreen extends StatelessWidget {
  const QuizzflySettingScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<QuizzflySettingBloc>(
      create: (context) => QuizzflySettingBloc(QuizzflySettingState(
        quizzflySettingModelObj: QuizzflySettingModel(),
        isPublic: arg[NavigationArgs.isPublic],
        title: arg[NavigationArgs.title],
        description: arg[NavigationArgs.description],
        coverImage: arg[NavigationArgs.coverImage],
      ))
        ..add(QuizzflySettingInitialEvent()),
      child: QuizzflySettingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageStack(context),
                SizedBox(height: 26.h),
                _buildTitleInput(context),
                SizedBox(height: 24.h),
                _buildDescriptionInput(context),
                SizedBox(height: 26.h),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "lbl_visible".tr,
                    style: CustomTextStyles.bodyMediumRobotoFontGray90003,
                  ),
                ),
                SizedBox(height: 4.h),
                _buildVisibilityRadios(context),
                SizedBox(height: 40.h),
                _buildHostLiveButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 56.h,
      actions: [
        AppbarLeadingImage(
          imagePath: ImageConstant.imgClose,
          height: 22.h,
          margin: EdgeInsets.only(right: 21.h),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return BlocBuilder<QuizzflySettingBloc, QuizzflySettingState>(
      builder: (context, state) {
        return Container(
          height: 200.h,
          width: double.maxFinite,
          margin: EdgeInsets.only(right: 4.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildImageWidget(state.coverImage),
              CustomElevatedButton(
                height: 30.h,
                width: 160.h,
                text: "lbl_change_image".tr,
                margin: EdgeInsets.only(top: 90.h),
                buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
                buttonTextStyle: CustomTextStyles.labelLargeWhiteA700,
                alignment: Alignment.topCenter,
                onPressed: () => _pickImage(context),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageWidget(dynamic coverImage) {
  if (coverImage is File) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.h), 
      child: Image.file(
        coverImage,
        height: 200.h, 
        width: double.maxFinite, 
        fit: BoxFit.cover,
      ),
    );
  } else if (coverImage is String) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.h),
      child: Image.network(
        coverImage,
        height: 200.h, 
        width: double.maxFinite, 
        fit: BoxFit.cover,
      ),
    );
  } else {
    return CustomImageView(
      imagePath: ImageConstant.imageBackToSchool,
      height: 250.h, 
      width: double.maxFinite,
      radius: BorderRadius.circular(20.h), 
    );
  }
}

  void _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      // ignore: use_build_context_synchronously
      context.read<QuizzflySettingBloc>().add(
            PickImageEvent(File(image.path)),
          );
    }
  }

  Widget _buildTitleInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_title".tr,
          style: CustomTextStyles.bodyMediumRobotoFontGray90003,
        ),
        SizedBox(height: 6.h),
        BlocSelector<QuizzflySettingBloc, QuizzflySettingState,
            TextEditingController?>(
          selector: (state) => state.titleController,
          builder: (context, titleController) {
            return CustomTextFormField(
              controller: titleController,
              hintText: "lbl_hello".tr,
              hintStyle: CustomTextStyles.bodyMediumRobotoGray90003,
              contentPadding: EdgeInsets.all(12.h),
              borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL81,
              fillcolor: appTheme.whiteA700,
            );
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_description".tr,
          style: CustomTextStyles.bodyMediumRobotoFontGray90003,
        ),
        SizedBox(height: 4.h),
        BlocSelector<QuizzflySettingBloc, QuizzflySettingState,
            TextEditingController?>(
          selector: (state) => state.descriptionController,
          builder: (context, descriptionController) {
            return CustomTextFormField(
              controller: descriptionController,
              hintText: "msg_this_is_a_back_to".tr,
              hintStyle: CustomTextStyles.bodyMediumRobotoGray90003,
              textInputAction: TextInputAction.done,
              maxLines: 4,
              contentPadding: EdgeInsets.fromLTRB(6.h, 10.h, 6.h, 8.h),
              borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL81,
              fillcolor: appTheme.whiteA700,
            );
          },
        ),
      ],
    );
  }

  Widget _buildVisibilityRadios(BuildContext context) {
    return BlocBuilder<QuizzflySettingBloc, QuizzflySettingState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomRadioButton(
              text: "lbl_public".tr,
              value: "public",
              groupValue: state.visibility,
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 30.h, 10.h),
              height: 50.h,
              decoration: CustomRadioButtonStyleHelper.customStyle(
                  backgroundColor: appTheme.whiteA700,
                  borderColor: appTheme.blueGray100),
              onChange: (value) {
                context
                    .read<QuizzflySettingBloc>()
                    .add(ChangeVisibilityEvent(value: value));
              },
            ),
            SizedBox(height: 10.h),
            CustomRadioButton(
              text: "lbl_private".tr,
              value: "private",
              groupValue: state.visibility,
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 30.h, 10.h),
              height: 50.h,
              decoration: CustomRadioButtonStyleHelper.customStyle(
                  backgroundColor: appTheme.whiteA700,
                  borderColor: appTheme.blueGray100),
              backgroundColor: appTheme.whiteA700,
              onChange: (value) {
                context
                    .read<QuizzflySettingBloc>()
                    .add(ChangeVisibilityEvent(value: value));
              },
            ),
          ],
        );
      },
    );
  }

  /// Section Widget
  Widget _buildHostLiveButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            height: 40.h,
            width: 160.h,
            text: "lbl_host_live".tr,
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.fillPrimaryRadius12,
            onPressed: () => callAPISettingQuizzfly(context),
          )
        ],
      ),
    );
  }

  callAPISettingQuizzfly(BuildContext context) {
    context.read<QuizzflySettingBloc>().add(
      UpdateSettingsEvent(
        onUpdateSettingsEventSuccess: () {
          _onUpdateQuizzflySettingsEventSuccess(context);
        },
      ),
    );
  }

  /// Displays a toast message using the Fluttertoast library.
  void _onUpdateQuizzflySettingsEventSuccess(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Succeed",
    );
  }
}
