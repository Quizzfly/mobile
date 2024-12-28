import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../models/detail_post_comment_item_model.dart';
import '../bloc/detail_post_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DetailPostCommentItemWidget extends StatefulWidget {
  DetailPostCommentItemWidget(this.detailPostCommentItemModelObj, {super.key});
  DetailPostCommentItemModel detailPostCommentItemModelObj;

  @override
  State<DetailPostCommentItemWidget> createState() =>
      _DetailPostCommentItemWidgetState();
}

class _DetailPostCommentItemWidgetState
    extends State<DetailPostCommentItemWidget> {
  final TextEditingController _commentController = TextEditingController();
  bool _isCommentSectionVisible = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _handleCommentIconTap() {
    setState(() {
      _isCommentSectionVisible = !_isCommentSectionVisible;
    });

    if (_isCommentSectionVisible) {
      context.read<DetailPostBloc>().add(
            GetListPostCommentRepliesEvent(
              postId: widget.detailPostCommentItemModelObj.id!,
              onListPostCommentRepliesSuccess: () {
                // Handle success if needed
              },
              onListPostCommentRepliesError: () {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: 'Failed to load replies',
                  ),
                );
              },
            ),
          );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Delete Confirmation',
      desc: 'Are you sure you want to delete this comment?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        context.read<DetailPostBloc>().add(
              DeleteCommentEvent(
                id: widget.detailPostCommentItemModelObj.id!,
                onDeleteCommentEventSuccess: () {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message: 'Comment deleted successfully',
                    ),
                  );
                  // Refresh comments list after deletion
                  context.read<DetailPostBloc>().add(
                        GetListPostCommentEvent(
                          postId: context.read<DetailPostBloc>().state.postId!,
                          onListPostCommentSuccess: () {},
                        ),
                      );
                },
                onDeleteCommentEventError: () {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: 'Failed to delete comment',
                    ),
                  );
                },
              ),
            );
      },
      btnCancelText: 'Cancel',
      btnCancelColor: appTheme.gray500,
      btnOkText: 'Delete',
      btnOkColor: appTheme.red900,
      buttonsTextStyle: const TextStyle(color: Colors.white),
    ).show();
  }

  void _handleSendReply(BuildContext context) {
    final bloc = context.read<DetailPostBloc>();
    final replyText = bloc.state.replyController?.text.trim() ?? '';

    if (replyText.isNotEmpty) {
      bloc.add(
        PostCommentEvent(
          postId: bloc.state.postId!,
          parentCommentId: widget.detailPostCommentItemModelObj.id!,
          onPostCommentSuccess: () {
            bloc.state.replyController?.clear();
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Reply posted successfully',
              ),
            );
          },
          onPostCommentError: () {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message: 'Failed to post reply',
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleCommentIconTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: widget.detailPostCommentItemModelObj.memberAvatar,
                height: 32.h,
                width: 32.h,
                radius: BorderRadius.circular(16.h),
                fit: BoxFit.cover,
              ),
              SizedBox(width: 8.h),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: appTheme.gray10001,
                          borderRadius: BorderRadiusStyle.roundedBorder20,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.h,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.detailPostCommentItemModelObj
                                        .memberName!,
                                    style: CustomTextStyles.labelMediumBlack900,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    widget
                                        .detailPostCommentItemModelObj.content!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.bodySmallGray90001
                                        .copyWith(
                                      height: 1.33,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                size: 20.h,
                                color: appTheme.gray500,
                              ),
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: appTheme.red900),
                                  ),
                                ),
                              ],
                              onSelected: (String value) {
                                if (value == 'delete') {
                                  _showDeleteConfirmationDialog(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Icon(
                              Icons.comment_outlined,
                              size: 12.h,
                              color: appTheme.gray500,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                widget
                                    .detailPostCommentItemModelObj.countReplies!
                                    .toString(),
                                style: CustomTextStyles.bodySmallGray90001,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Rest of the widget remains the same...
          if (_isCommentSectionVisible) ...[
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 40.h),
              child: BlocSelector<DetailPostBloc, DetailPostState,
                  TextEditingController?>(
                selector: (state) => state.commentController,
                builder: (context, commentController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.detailPostCommentItemModelObj.replies
                              ?.isNotEmpty ??
                          false) ...[
                        ...widget.detailPostCommentItemModelObj.replies!
                            .map((reply) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: reply.memberAvatar,
                                  height: 24.h,
                                  width: 24.h,
                                  radius: BorderRadius.circular(12.h),
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 8.h),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color: appTheme.gray10001,
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                reply.memberName!,
                                                style: CustomTextStyles
                                                    .labelMediumBlack900,
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(
                                                reply.content!,
                                                style: CustomTextStyles
                                                    .bodySmallGray90001,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          icon: Icon(
                                            Icons.more_vert,
                                            size: 20.h,
                                            color: appTheme.gray500,
                                          ),
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: appTheme.red900),
                                              ),
                                            ),
                                          ],
                                          onSelected: (String value) {
                                            if (value == 'delete') {
                                              _showDeleteConfirmationDialog(
                                                  context);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 8.h),
                      ],
                      Row(
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
                              selector: (state) => state.replyController,
                              builder: (context, replyController) {
                                return CustomTextFormField(
                                  controller: replyController,
                                  hintText: "Write your reply...",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.h,
                                    vertical: 8.h,
                                  ),
                                  borderDecoration: TextFormFieldStyleHelper
                                      .outlineBlueGrayTL82
                                      .copyWith(
                                    borderRadius: BorderRadius.circular(20.h),
                                  ),
                                  fillcolor: appTheme.gray50,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 8.h),
                          GestureDetector(
                            onTap: () => _handleSendReply(context),
                            child: Container(
                              padding: EdgeInsets.all(8.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: appTheme.deppPurplePrimary,
                                  width: 1.5.h,
                                ),
                              ),
                              child: Icon(
                                Icons.send,
                                color: appTheme.deppPurplePrimary,
                                size: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
