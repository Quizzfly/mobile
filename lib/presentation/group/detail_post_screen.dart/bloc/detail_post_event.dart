part of 'detail_post_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///DetailPost widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class DetailPostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the DetailPost widget is first created.
class DetailPostInitialEvent extends DetailPostEvent {
  @override
  List<Object?> get props => [];
}

class FetchDetailPostEvent extends DetailPostEvent {
  FetchDetailPostEvent({
    required this.groupId,
    required this.postId,
    this.onGetDetailPostSuccess,
    this.onGetDetailPostError,
  });

  final String groupId;
  final String postId;
  final Function? onGetDetailPostSuccess;
  final Function? onGetDetailPostError;

  @override
  List<Object?> get props =>
      [groupId, postId, onGetDetailPostSuccess, onGetDetailPostError];
}

class GetListPostCommentEvent extends DetailPostEvent {
  GetListPostCommentEvent({
    required this.postId,
    this.onListPostCommentSuccess,
    this.onListPostCommentError,
  });

  final String postId;
  final Function? onListPostCommentSuccess;
  final Function? onListPostCommentError;

  @override
  List<Object?> get props =>
      [postId, onListPostCommentSuccess, onListPostCommentError];
}
