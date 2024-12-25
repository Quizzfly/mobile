part of 'detail_post_bloc.dart';

/// Represents the state of DetailPost in the application.
// ignore_for_file: must_be_immutable
class DetailPostState extends Equatable {
  DetailPostState({
    this.commentController,
    this.replyController,
    this.detailPostModelObj,
    this.groupId,
    this.postId,
    this.isLoading = false, 
  });

  TextEditingController? commentController;
  TextEditingController? replyController;
  DetailPostModel? detailPostModelObj;
  String? groupId;
  String? postId;
  bool isLoading;

  @override
  List<Object?> get props => [
        commentController,
        replyController,
        detailPostModelObj,
        groupId,
        postId,
        isLoading,
      ];

  DetailPostState copyWith({
    TextEditingController? commentController,
    TextEditingController? replyController,
    DetailPostModel? detailPostModelObj,
    String? groupId,
    String? postId,
    bool? isLoading,
  }) {
    return DetailPostState(
      commentController: commentController ?? this.commentController,
      replyController: replyController ?? this.replyController,
      detailPostModelObj: detailPostModelObj ?? this.detailPostModelObj,
      groupId: groupId ?? this.groupId,
      postId: postId ?? this.postId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
