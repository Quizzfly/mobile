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

class InviteMemberEvent extends CommunityEvent {
  final String groupId;
  final List<String> emails;
  final Function? onInviteMemberSuccess;
  final Function? onInviteMemberError;

  InviteMemberEvent({
    required this.groupId,
    required this.emails,
    this.onInviteMemberSuccess,
    this.onInviteMemberError,
  });

  @override
  List<Object?> get props => [
        groupId,
        emails,
        onInviteMemberSuccess,
        onInviteMemberError,
      ];
}

class ImagePickedEvent extends CommunityEvent {
  final List<dynamic> imageFile;

  ImagePickedEvent(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

// ignore: must_be_immutable
class CreatePostNewPostEvent extends CommunityEvent {
  CreatePostNewPostEvent({
    this.groupId,
    this.onPostNewPostSuccess,
    this.onPostNewPostError,
  });

  String? groupId;
  Function? onPostNewPostSuccess;
  Function? onPostNewPostError;

  @override
  List<Object?> get props =>
      [groupId, onPostNewPostSuccess, onPostNewPostSuccess];
}

// ignore: must_be_immutable
class CreateGetLibraryEvent extends CommunityEvent {
  CreateGetLibraryEvent({
    this.id,
    this.onGetLibrarySuccess,
    this.onGetLibraryError,
  });

  Function? onGetLibrarySuccess;
  Function? onGetLibraryError;
  String? id;
  @override
  List<Object?> get props => [onGetLibrarySuccess, onGetLibraryError, id];
}

class SelectQuizzflyEvent extends CommunityEvent {
  final LibraryListItemModel? quizzfly;
  final bool? forceUpdateSelectedQuizzfly;
  SelectQuizzflyEvent({this.quizzfly, this.forceUpdateSelectedQuizzfly});

  @override
  List<Object?> get props => [quizzfly, forceUpdateSelectedQuizzfly];
}

class DeletePostEvent extends CommunityEvent {
  DeletePostEvent({
    this.id,
    this.onDeletePostEventSuccess,
    this.onDeletePostEventError,
  });

  final Function? onDeletePostEventSuccess;
  final Function? onDeletePostEventError;
  final String? id;
  @override
  List<Object?> get props =>
      [onDeletePostEventSuccess, onDeletePostEventError, id];
}
