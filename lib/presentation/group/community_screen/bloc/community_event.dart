part of 'community_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///DeleteAccount widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class CommunityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the DeleteAccount widget is first created.
class CommunityInitialEvent extends CommunityEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class CreateGetCommunityPostsEvent extends CommunityEvent {
  CreateGetCommunityPostsEvent({
    this.groupId,
    this.onGetCommunityPostsSuccess,
    this.onGetCommunityPostsError,
  });

  String? groupId;
  Function? onGetCommunityPostsSuccess;
  Function? onGetCommunityPostsError;

  @override
  List<Object?> get props =>
      [groupId, onGetCommunityPostsSuccess, onGetCommunityPostsError];
}

class ReactPostEvent extends CommunityEvent {
  ReactPostEvent({
    required this.postId,
    required this.postIndex,
    this.onReactPostSuccess,
    this.onReactPostError,
  });

  final String postId;
  final int postIndex;
  final Function? onReactPostSuccess;
  final Function? onReactPostError;

  @override
  List<Object?> get props =>
      [postId, postIndex, onReactPostSuccess, onReactPostError];
}
