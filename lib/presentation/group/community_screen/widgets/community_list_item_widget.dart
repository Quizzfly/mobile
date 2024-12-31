import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../../../../../core/app_export.dart';
import '../../../../routes/navigation_args.dart';
import '../bloc/community_bloc.dart';
import '../models/community_list_item_model.dart';

// ignore: must_be_immutable
class CommunityListItemWidget extends StatelessWidget {
  CommunityListItemWidget(
    this.communityListItemModelObj, {
    super.key,
    this.callDetail,
    required this.index,
    this.onDelete,
  });
  final CommunityListItemModel communityListItemModelObj;
  VoidCallback? callDetail;
  final int index;
  Function(String)? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callDetail?.call();
      },
      child: Container(
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
            _buildHeader(context),
            SizedBox(height: 12.h),
            Divider(
              color: appTheme.gray100,
            ),
            SizedBox(height: 12.h),
            _buildDescriptionSection(context),
            SizedBox(height: 20.h),
            _buildInteractionBar(),
            SizedBox(height: 16.h),
            Divider(
              color: appTheme.gray100,
            ),
            SizedBox(height: 12.h),
            // _buildCommentSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage:
              NetworkImage(communityListItemModelObj.memberAvatar!),
          backgroundColor: Colors.transparent,
          // ignore: unnecessary_null_comparison
          child: PrefUtils().getAvatar() == null
              ? const Icon(Icons.person, size: 24)
              : null,
        ),
        SizedBox(width: 12.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                communityListItemModelObj.memberName!,
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
        Container(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: appTheme.gray500,
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: appTheme.red900)),
              ),
            ],
            onSelected: (String value) {
              if (value == 'delete') {
                _showDeleteConfirmationDialog(context);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          communityListItemModelObj.description ?? '',
          style:
              CustomTextStyles.bodyMediumRobotoGray90003.copyWith(height: 1.5),
        ),
        SizedBox(height: 12.h),
        if (communityListItemModelObj.images != null &&
            communityListItemModelObj.images!.isNotEmpty)
          _buildImageGrid(communityListItemModelObj.images),
        SizedBox(height: 12.h),
        if (communityListItemModelObj.quizzflyId != null &&
            communityListItemModelObj.quizzflyId!.isNotEmpty) ...[
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  color: appTheme.whiteA700.withOpacity(1),
                  borderRadius: BorderRadiusStyle.roundedBorder20,
                  border: Border.all(
                    color: appTheme.blueGray10002,
                    width: 0.5.h,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.black900.withOpacity(0.05),
                      spreadRadius: 0.h,
                      blurRadius: 10.h,
                      offset: const Offset(0, 4),
                    )
                  ]),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 118.h,
                          width: 118.h,
                          child: CustomImageView(
                            imagePath: communityListItemModelObj.quizzflyImage,
                            height: 130.h,
                            width: double.maxFinite,
                            radius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.zero,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.h),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            communityListItemModelObj.quizzflyTitle ?? "",
                            style: theme.textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 10.h,
                    bottom: 10.h,
                    child: Hero(
                      tag:
                          'library_cover_image_${communityListItemModelObj.quizzflyId}',
                      child: Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.h),
                          onTap: () {
                            NavigatorService.pushNamed(
                              AppRoutes.quizzflyDetailScreen,
                              arguments: {
                                NavigationArgs.id:
                                    communityListItemModelObj.quizzflyId,
                                NavigationArgs.heroTag:
                                    'library_cover_image_${communityListItemModelObj.quizzflyId}',
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.h, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: appTheme.whiteA700.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20.h),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: appTheme.blueGray300,
                                  size: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.h),
                                  child: Text(
                                    'Edit',
                                    style: CustomTextStyles.bodySmallGray90001,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]
      ],
    );
  }

  Widget _buildImageGrid(List<String>? imageUrls) {
    if (imageUrls == null || imageUrls.isEmpty) return const SizedBox.shrink();

    final int imageCount = imageUrls.length;

    if (imageCount == 1) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.h),
          child: Image.network(
            imageUrls[0],
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // If two images, show them side by side
    if (imageCount == 2) {
      return Row(
        children: [
          for (var i = 0; i < 2; i++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: i == 0 ? 0 : 8.h),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.h),
                    child: Image.network(
                      imageUrls[i],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    // If three images, show one large and two small
    if (imageCount == 3) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.h),
                child: Image.network(
                  imageUrls[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Column(
              children: [
                for (var i = 1; i < 3; i++) ...[
                  if (i > 1) SizedBox(height: 8.h),
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.h),
                      child: Image.network(
                        imageUrls[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    }

    // For 4 or more images, show grid with "more" overlay on last image if needed
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.h,
        mainAxisSpacing: 8.h,
      ),
      itemCount: imageCount > 4 ? 4 : imageCount,
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.h),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
            if (index == 3 && imageCount > 4)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.h),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      '+${imageCount - 4}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildInteractionBar() {
    return Row(
      children: [
        _buildLikeButton(),
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
          communityListItemModelObj.type!,
          style: CustomTextStyles.bodyMediumGraphik,
        ),
      ],
    );
  }

  // Add new method for like button
  Widget _buildLikeButton() {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        return LikeButton(
          size: 20.h,
          isLiked: communityListItemModelObj.isLiked,
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.thumb_up,
              color: isLiked ? appTheme.deppPurplePrimary : appTheme.gray500,
              size: 20.h,
            );
          },
          likeCount: communityListItemModelObj.likeCount,
          countBuilder: (int? count, bool isLiked, String text) {
            return Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: Text(
                count.toString(),
                style: CustomTextStyles.bodyMediumGraphik.copyWith(
                  color:
                      isLiked ? appTheme.deppPurplePrimary : appTheme.gray500,
                ),
              ),
            );
          },
          onTap: (isLiked) async {
            context.read<CommunityBloc>().add(
                  ReactPostEvent(
                    postId: communityListItemModelObj.id ?? '',
                    postIndex: index,
                    onReactPostSuccess: () {},
                    onReactPostError: () {},
                  ),
                );
            return !isLiked;
          },
        );
      },
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Delete Confirmation',
      desc: 'Are you sure you want to delete this item?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (onDelete != null && communityListItemModelObj.id != null) {
          onDelete!(communityListItemModelObj.id!);
        }
      },
      btnCancelText: 'Cancel',
      btnCancelColor: appTheme.gray500,
      btnOkText: 'Delete',
      btnOkColor: appTheme.red900,
      buttonsTextStyle: const TextStyle(color: Colors.white),
    ).show();
  }
}
