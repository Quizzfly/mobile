import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/community_bloc.dart';
import 'models/community_activity_tab_model.dart';
import 'models/community_list_item_model.dart';
import 'widgets/community_list_item_widget.dart';

class CommunityActivityTabPage extends StatefulWidget {
  const CommunityActivityTabPage({super.key});
  @override
  CommunityActivityTabPageState createState() =>
      CommunityActivityTabPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<CommunityBloc>(
      create: (context) => CommunityBloc(CommunityState(
        communityActivityTabModelObj: CommunityActivityTabModel(),
      ))
        ..add(CommunityInitialEvent()),
      child: const CommunityActivityTabPage(),
    );
  }
}

class CommunityActivityTabPageState extends State<CommunityActivityTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 4.h,
      ),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildPostCreationSection(context),
                  SizedBox(height: 16.h),
                  _buildCommunityList(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPostInputField(BuildContext context) {
    return Expanded(
      child:
          BlocSelector<CommunityBloc, CommunityState, TextEditingController?>(
        selector: (state) => state.postInputFieldController,
        builder: (context, postInputFieldController) {
          return CustomTextFormField(
            controller: postInputFieldController,
            hintText: "msg_post_something".tr,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 12.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL82,
            fillcolor: appTheme.whiteA700,
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildAddNewPostButton(BuildContext context) {
    return CustomElevatedButton(
      height: 32.h,
      text: "lbl_add_new_post".tr,
      buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
      buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
    );
  }

  /// Section Widget
  Widget _buildPostCreationSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder20,
        border: Border.all(
          color: appTheme.whiteA700,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.08),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              1.01,
              1.01,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 6.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imageAvatar,
                  height: 32.h,
                  width: 32.h,
                ),
                SizedBox(width: 16.h),
                _buildPostInputField(context)
              ],
            ),
          ),
          SizedBox(height: 12.h),
          const SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
          SizedBox(height: 12.h),
          _buildAddNewPostButton(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCommunityList(BuildContext context) {
    return Expanded(
      child:
          BlocSelector<CommunityBloc, CommunityState, CommunityActivityTabModel?>(
        selector: (state) => state.communityActivityTabModelObj,
        builder: (context, communityActivityTabModelObj) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 16.h,
              );
            },
            itemCount:
                communityActivityTabModelObj?.communityListItemList.length ?? 0,
            itemBuilder: (context, index) {
              CommunityListItemModel model =
                  communityActivityTabModelObj?.communityListItemList[index] ??
                      CommunityListItemModel();
              return CommunityListItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }
}
