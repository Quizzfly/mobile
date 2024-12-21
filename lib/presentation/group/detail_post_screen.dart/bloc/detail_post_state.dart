part of 'detail_post_bloc.dart';

/// Represents the state of DetailPost in the application.
// ignore_for_file: must_be_immutable
class DetailPostState extends Equatable {
  DetailPostState(
      {this.commentController,
      this.detailPostModelObj,
      this.groupId,
      this.postId});
  TextEditingController? commentController;
  DetailPostModel? detailPostModelObj;
  String? groupId;
  String? postId;
  @override
  List<Object?> get props =>
      [commentController, detailPostModelObj, groupId, postId];
  DetailPostState copyWith({
    TextEditingController? commentController,
    DetailPostModel? detailPostModelObj,
    String? groupId,
    String? postId,
  }) {
    return DetailPostState(
      commentController: commentController ?? this.commentController,
      detailPostModelObj: detailPostModelObj ?? this.detailPostModelObj,
      groupId: groupId ?? this.groupId,
      postId: postId ?? this.postId,
    );
  }
}
