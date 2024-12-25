import "package:flutter/material.dart";
import "models/detail_post_model.dart";
import "widget/comment_shimmer_loading.dart";
import "widget/detail_post_comment_item_widget.dart";
import "package:quizzfly_application_flutter/routes/navigation_args.dart";
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";
import "../../../core/app_export.dart";
import "../../../widgets/custom_text_form_field.dart";
import "bloc/detail_post_bloc.dart";
import 'package:like_button/like_button.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen({super.key});

  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<DetailPostBloc>(
      create: (context) => DetailPostBloc(DetailPostState(
          detailPostModelObj: DetailPostModel(),
          postId: arg[NavigationArgs.id],
          groupId: arg[NavigationArgs.groupId]))
        ..add(DetailPostInitialEvent()),
      child: const DetailPostScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: EdgeInsets.only(left: 5.h, top: 16.h),
            color: appTheme.whiteA700,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 40.h,
              leading: Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
              titleSpacing: 15.h,
              title: const Text(
                'Detail',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 18.h),
              child: Column(
                children: [
                  SizedBox(height: 4.h),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      left: 2.h,
                      top: 12.h,
                      right: 2.h,
                    ),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildProfileSection(context),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            indent: 8.h,
                            endIndent: 8.h,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildDescriptionSection(context),
                        SizedBox(height: 14.h),
                        _buildInteractionBar(context),
                        SizedBox(height: 14.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            indent: 8.h,
                            endIndent: 8.h,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildCommentSection(context),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            indent: 8.h,
                            endIndent: 8.h,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _buildCommentsList(context),
                        SizedBox(height: 10.h)
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
  Widget _buildProfileSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child:
                BlocSelector<DetailPostBloc, DetailPostState, DetailPostModel?>(
              selector: (state) => state.detailPostModelObj,
              builder: (context, detailPostModelObj) {
                return Row(
                  children: [
                    CustomImageView(
                      imagePath: detailPostModelObj!.memberAvatar,
                      height: 34.h,
                      width: 34.h,
                      radius: BorderRadius.circular(
                        20.h,
                      ),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 12.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detailPostModelObj.memberName!,
                            style: CustomTextStyles.titleMediumRobotoBlack900,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDescriptionSection(BuildContext context) {
    return BlocSelector<DetailPostBloc, DetailPostState, DetailPostModel?>(
      selector: (state) => state.detailPostModelObj,
      builder: (context, detailPostModelObj) {
        if (detailPostModelObj == null) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detailPostModelObj.content ?? '',
              style: CustomTextStyles.bodyMediumRobotoGray90003
                  .copyWith(height: 1.5),
            ),
            SizedBox(height: 12.h),
            if (detailPostModelObj.files != null &&
                detailPostModelObj.files!.isNotEmpty)
              _buildImageGrid(detailPostModelObj.files),
            if (detailPostModelObj.quizzflyId != null &&
                detailPostModelObj.quizzflyId!.isNotEmpty) ...[
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
                                imagePath: detailPostModelObj.quizzflyImage,
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
                                detailPostModelObj.quizzflyTitle ?? "",
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
                              'library_cover_image_${detailPostModelObj.quizzflyId}',
                          child: Material(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20.h),
                              onTap: () {
                                NavigatorService.pushNamed(
                                  AppRoutes.quizzflyDetailScreen,
                                  arguments: {
                                    NavigationArgs.id:
                                        detailPostModelObj.quizzflyId,
                                    NavigationArgs.heroTag:
                                        'library_cover_image_${detailPostModelObj.quizzflyId}',
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
                                        style:
                                            CustomTextStyles.bodySmallGray90001,
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
      },
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

  Widget _buildInteractionButton(
      BuildContext context, IconData icon, int count, bool isLike) {
    if (!isLike) {
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

    return BlocBuilder<DetailPostBloc, DetailPostState>(
      builder: (context, state) {
        return LikeButton(
          size: 20.h,
          isLiked: state.detailPostModelObj?.isLiked ?? false,
          likeCount: count,
          countBuilder: (int? count, bool isLiked, String text) {
            return Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: Text(
                count.toString(),
                style: CustomTextStyles.bodyMediumGraphik,
              ),
            );
          },
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.thumb_up,
              color: isLiked ? appTheme.deppPurplePrimary : appTheme.gray500,
              size: 20.h,
            );
          },
          onTap: (isLiked) async {
            context.read<DetailPostBloc>().add(
                  ReactPostEvent(
                    postId: state.postId!,
                    onReactPostSuccess: () {},
                    onReactPostError: () {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: 'Failed to update reaction',
                        ),
                      );
                    },
                  ),
                );
            return !isLiked;
          },
        );
      },
    );
  }

// Update the _buildInteractionBar method
  Widget _buildInteractionBar(BuildContext context) {
    return BlocSelector<DetailPostBloc, DetailPostState, DetailPostModel?>(
      selector: (state) => state.detailPostModelObj,
      builder: (context, detailPostModelObj) {
        return Row(
          children: [
            _buildInteractionButton(
              context,
              Icons.thumb_up_off_alt_outlined,
              detailPostModelObj!.reactCount!,
              true, // This is a like button
            ),
            SizedBox(width: 15.h),
            _buildInteractionButton(
              context,
              Icons.comment_outlined,
              detailPostModelObj.commentCount!,
              false, // This is not a like button
            ),
            const Spacer(),
            Icon(
              Icons.ios_share_outlined,
              size: 20.h,
              color: appTheme.gray500,
            ),
            SizedBox(width: 8.h),
            Text(
              detailPostModelObj.type!,
              style: CustomTextStyles.bodyMediumGraphik,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCommentSection(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32.h,
          height: 32.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(PrefUtils().getAvatar()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12.h),
        Expanded(
          child: BlocSelector<DetailPostBloc, DetailPostState,
                  TextEditingController?>(
              selector: (state) => state.commentController,
              builder: (context, commentController) {
                return CustomTextFormField(
                  controller: commentController,
                  hintText: "msg_write_your_comment".tr,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 8.h,
                  ),
                  borderDecoration:
                      TextFormFieldStyleHelper.outlineBlueGrayTL82.copyWith(
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  fillcolor: appTheme.gray50,
                );
              }),
        ),
        SizedBox(width: 8.h),
        _buildActionButton(context, Icons.attach_file, appTheme.gray500),
        SizedBox(width: 8.h),
        _buildActionButton(context, Icons.send, appTheme.deppPurplePrimary),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, Color color) {
    return GestureDetector(
      onTap: icon == Icons.send ? () => _onTapSend(context) : null,
      child: Container(
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
      ),
    );
  }

  /// Section Widget
  Widget _buildCommentsList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<DetailPostBloc, DetailPostState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CommentShimmerLoading();
              }

              final comments =
                  state.detailPostModelObj?.detailPostCommentItemList ?? [];

              return ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 26.h),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return DetailPostCommentItemWidget(comments[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _onTapSend(BuildContext context) {
    if (context
            .read<DetailPostBloc>()
            .state
            .commentController
            ?.text
            .trim()
            .isNotEmpty ??
        false) {
      context.read<DetailPostBloc>().add(
            PostCommentEvent(
              postId: context.read<DetailPostBloc>().state.postId!,
              parentCommentId: '',
              onPostCommentSuccess: () {
                _onPostCommentSuccess(context);
              },
              onPostCommentError: () {
                _onPostCommentError(context);
              },
            ),
          );
    }
  }

  void _onPostCommentSuccess(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'Comment posted successfully',
      ),
    );
  }

  void _onPostCommentError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Failed to post comment',
      ),
    );
  }
}
