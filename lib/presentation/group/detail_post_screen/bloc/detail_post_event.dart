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

class GetListPostCommentRepliesEvent extends DetailPostEvent {
  GetListPostCommentRepliesEvent({
    required this.postId,
    this.onListPostCommentRepliesSuccess,
    this.onListPostCommentRepliesError,
  });

  final String postId;
  final Function? onListPostCommentRepliesSuccess;
  final Function? onListPostCommentRepliesError;

  @override
  List<Object?> get props =>
      [postId, onListPostCommentRepliesSuccess, onListPostCommentRepliesError];
}

class PostCommentEvent extends DetailPostEvent {
  PostCommentEvent({
    required this.postId,
    required this.parentCommentId,
    this.onPostCommentSuccess,
    this.onPostCommentError,
  });

  final String postId;
  final String parentCommentId;
  final Function? onPostCommentSuccess;
  final Function? onPostCommentError;

  @override
  List<Object?> get props =>
      [postId, parentCommentId, onPostCommentSuccess, onPostCommentError];
}

class ReactPostEvent extends DetailPostEvent {
  ReactPostEvent({
    required this.postId,
    this.onReactPostSuccess,
    this.onReactPostError,
  });

  final String postId;
  final Function? onReactPostSuccess;
  final Function? onReactPostError;

  @override
  List<Object?> get props => [postId, onReactPostSuccess, onReactPostError];
}

class NewCommentReceivedEvent extends DetailPostEvent {
  final DetailPostCommentItemModel comment;

  NewCommentReceivedEvent(this.comment);

  @override
  List<Object?> get props => [comment];
}

class DeleteCommentEvent extends DetailPostEvent {
  DeleteCommentEvent({
    this.id,
    this.onDeleteCommentEventSuccess,
    this.onDeleteCommentEventError,
  });

  final Function? onDeleteCommentEventSuccess;
  final Function? onDeleteCommentEventError;
  final String? id;
  @override
  List<Object?> get props =>
      [onDeleteCommentEventSuccess, onDeleteCommentEventError, id];
}

class CommentDeletedEvent extends DetailPostEvent {
  final DetailPostCommentItemModel comment;

  CommentDeletedEvent(this.comment);

  @override
  List<Object?> get props => [comment];
}
