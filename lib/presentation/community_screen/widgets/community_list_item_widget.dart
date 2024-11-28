import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../models/community_list_item_model.dart';

class CommunityListItemWidget extends StatelessWidget {
  CommunityListItemWidget(this.communityListItemModelObj, {super.key});
  final CommunityListItemModel communityListItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 5.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: appTheme.whiteA700,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 10.h,
            offset: Offset(1.h, 1.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 12.h),
          Divider(
            color: appTheme.gray100,
          ),
          SizedBox(height: 12.h),
          _buildContent(),
          SizedBox(height: 16.h),
          _buildInteractionBar(),
          SizedBox(height: 16.h),
          Divider(
            color: appTheme.gray100,
          ),
          SizedBox(height: 12.h),
          _buildCommentSection(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.h,
          backgroundImage: AssetImage(ImageConstant.imageAvatar),
        ),
        SizedBox(width: 12.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                communityListItemModelObj.name!,
                style: CustomTextStyles.titleMediumRobotoBlack900,
              ),
              SizedBox(height: 2.h),
              Text(
                communityListItemModelObj.host!,
                style: CustomTextStyles.labelLargeGray500,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          communityListItemModelObj.description!,
          style:
              CustomTextStyles.bodyMediumRobotoGray90003.copyWith(height: 1.5),
        ),
        SizedBox(height: 12.h),
        if (communityListItemModelObj.image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8.h),
            child: Image.asset(
              communityListItemModelObj.image!,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  Widget _buildInteractionBar() {
    return Row(
      children: [
        _buildInteractionButton(
          Icons.thumb_up_off_alt_outlined,
          communityListItemModelObj.likeCount!,
        ),
        SizedBox(width: 15.h),
        _buildInteractionButton(
          Icons.comment_outlined,
          communityListItemModelObj.commentCount!,
        ),
        const Spacer(),
        Icon(
          Icons.ios_share_outlined,
          size: 20.h,
          color: appTheme.gray500,
        ),
        SizedBox(width: 8.h),
        Text(
          communityListItemModelObj.share!,
          style: CustomTextStyles.bodyMediumGraphik,
        ),
      ],
    );
  }

  Widget _buildInteractionButton(IconData icon, int count) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.h,
          color: appTheme.gray500,
        ),
        SizedBox(width: 8.h),
        Text(
          count.toString(),
          style: CustomTextStyles.bodyMediumGraphik,
        ),
      ],
    );
  }

  Widget _buildCommentSection(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16.h,
          backgroundImage: AssetImage(ImageConstant.imageAvatar),
        ),
        SizedBox(width: 12.h),
        Expanded(
          child: CustomTextFormField(
            controller: communityListItemModelObj.commentInputFieldController,
            hintText: "msg_write_your_comment".tr,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL82,
            fillcolor: appTheme.gray50,
          ),
        ),
        SizedBox(width: 8.h),
        _buildActionButton(Icons.attach_file, appTheme.gray500),
        SizedBox(width: 8.h),
        _buildActionButton(Icons.send, appTheme.deppPurplePrimary),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 1.5.h,
        ),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20.h,
      ),
    );
  }
}
