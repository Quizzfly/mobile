import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/list_comment/post_react_post_resp.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../data/models/detail_post/get_detail_post_resp.dart';
import '../../../../data/models/list_comment/get_list_comment_resp.dart';
import '../../../../data/models/list_comment/post_comment_req.dart';
import '../../../../core/app_export.dart';
import '../../../../data/models/list_comment/post_comment_resp.dart';
import '../../../../data/repository/repository.dart';
import '../models/detail_post_comment_item_model.dart';
import '../models/detail_post_model.dart';
part 'detail_post_event.dart';
part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  final Repository _repository = Repository();
  late IO.Socket socket;
  var getDetailPostResp = GetDetailPostResp();
  var getListCommentPostResp = GetListCommentResp();
  var postPostCommentResp = PostCommentResp();
  var postReactPostResp = PostReactPostResp();
  DetailPostBloc(super.initialState) {
    on<DetailPostInitialEvent>(_onInitialize);
    on<FetchDetailPostEvent>(_callGetDetailPost);
    on<GetListPostCommentEvent>(_callGetListCommentPost);
    on<PostCommentEvent>(_callPostComment);
    on<NewCommentReceivedEvent>(_handleNewComment);
    on<ReactPostEvent>(_callReactPost);
    on<GetListPostCommentRepliesEvent>(_callGetListCommentRepliesPost);
    on<DeleteCommentEvent>(_callDeleteComment);
    on<CommentDeletedEvent>(_handleDeletedComment);

    // Initialize socket
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('https://api.quizzfly.site/groups', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'query': {'user_id': PrefUtils().getUserId()}
    });

    socket.connect();

    socket.on('commentPost', (data) {
      if (data is Map && data.isNotEmpty) {
        final newComment = DetailPostCommentItemModel(
          id: data['id'],
          content: data['content'],
          createdAt: data['created_at'],
          memberName: data['member']['name'],
          memberAvatar: data['member']['avatar'],
          parentCommentId: data['parent_comment_id'],
        );

        add(NewCommentReceivedEvent(newComment));
      }
    });
    socket.on('deleteCommentPost', (data) {
      if (data is Map && data.isNotEmpty) {
        final deletedComment = DetailPostCommentItemModel(
          id: data['id'],
          content: data['content'],
          createdAt: data['created_at'],
          memberName: data['member']['name'],
          memberAvatar: data['member']['avatar'],
          parentCommentId: data['parent_comment_id'],
        );

        add(CommentDeletedEvent(deletedComment));
      }
    });
  }

  FutureOr<void> _handleNewComment(
    NewCommentReceivedEvent event,
    Emitter<DetailPostState> emit,
  ) {
    final currentComments = List<DetailPostCommentItemModel>.from(
        state.detailPostModelObj?.detailPostCommentItemList ?? []);

    if (event.comment.parentCommentId != null &&
        event.comment.parentCommentId!.isNotEmpty) {
      final parentComment = currentComments.firstWhere(
        (comment) => comment.id == event.comment.parentCommentId,
      );

      final updatedParentComment = parentComment.copyWith(
        replies: [...parentComment.replies ?? [], event.comment],
      );

      final updatedComments = currentComments.map((comment) {
        return comment.id == parentComment.id ? updatedParentComment : comment;
      }).toList();

      emit(state.copyWith(
        detailPostModelObj: state.detailPostModelObj?.copyWith(
          detailPostCommentItemList: updatedComments,
        ),
      ));
    } else {
      currentComments.insert(0, event.comment);

      emit(state.copyWith(
        detailPostModelObj: state.detailPostModelObj?.copyWith(
          detailPostCommentItemList: currentComments,
        ),
      ));
    }
  }

  FutureOr<void> _handleDeletedComment(
    CommentDeletedEvent event,
    Emitter<DetailPostState> emit,
  ) {
    final currentComments = List<DetailPostCommentItemModel>.from(
        state.detailPostModelObj?.detailPostCommentItemList ?? []);

    if (event.comment.parentCommentId != null &&
        event.comment.parentCommentId!.isNotEmpty) {
      // Handle reply deletion
      final parentComment = currentComments.firstWhere(
        (comment) => comment.id == event.comment.parentCommentId,
      );

      final updatedReplies = parentComment.replies
          ?.where((reply) => reply.id != event.comment.id)
          .toList();

      final updatedParentComment =
          parentComment.copyWith(replies: updatedReplies);

      final updatedComments = currentComments.map((comment) {
        return comment.id == parentComment.id ? updatedParentComment : comment;
      }).toList();

      emit(state.copyWith(
        detailPostModelObj: state.detailPostModelObj?.copyWith(
          detailPostCommentItemList: updatedComments,
        ),
      ));
    } else {
      final updatedComments = currentComments
          .where((comment) => comment.id != event.comment.id)
          .toList();

      emit(state.copyWith(
        detailPostModelObj: state.detailPostModelObj?.copyWith(
          detailPostCommentItemList: updatedComments,
        ),
      ));
    }
  }

  FutureOr<void> _onInitialize(
    DetailPostInitialEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      emit(state.copyWith(
        replyController: TextEditingController(),
        commentController: TextEditingController(),
      ));

      add(FetchDetailPostEvent(
        groupId: state.groupId!,
        postId: state.postId!,
        onGetDetailPostSuccess: () {},
      ));
    } catch (e) {
      debugPrint('Error initializing detail post: $e');
    }
  }

  FutureOr<void> _callGetDetailPost(
    FetchDetailPostEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.getDetailPost(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        groupId: event.groupId,
        postId: event.postId,
      ).then((value) {
        getDetailPostResp = value;
        _onGetDetailPostSuccess(value, emit);
        event.onGetDetailPostSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetDetailPostError();
        event.onGetDetailPostError?.call();
      });
    } catch (e) {
      debugPrint('Error loading detail post: $e');
      _onGetDetailPostError();
      event.onGetDetailPostError?.call();
    }
  }

  void _onGetDetailPostSuccess(
    GetDetailPostResp resp,
    Emitter<DetailPostState> emit,
  ) {
    if (resp.data != null) {
      final detailPost = DetailPostModel.fromPostData(
        resp.data!.toJson(),
      );

      emit(state.copyWith(
        detailPostModelObj: detailPost,
      ));
      add(GetListPostCommentEvent(
        postId: resp.data!.id!,
        onListPostCommentSuccess: () {},
      ));
    }
  }

  void _onGetDetailPostError() {
    debugPrint('Error fetching detail post');
  }

  FutureOr<void> _callGetListCommentPost(
    GetListPostCommentEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      String? accessToken = PrefUtils().getAccessToken();
      await Future.delayed(const Duration(seconds: 1));

      await _repository.getListCommentPost(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        postId: event.postId,
      ).then((value) {
        getListCommentPostResp = value;
        _onGetListCommentPostSuccess(value, emit);
        event.onListPostCommentSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetListCommentPostError();
        event.onListPostCommentError?.call();
      });
    } catch (e) {
      debugPrint('Error loading detail post: $e');
      _onGetDetailPostError();
      event.onListPostCommentError?.call();
    }
  }

  void _onGetListCommentPostSuccess(
    GetListCommentResp resp,
    Emitter<DetailPostState> emit,
  ) {
    if (resp.data != null) {
      final comments = resp.data?.map((commentData) {
            return DetailPostCommentItemModel.fromCommentData(
              json: commentData.toJson(),
            );
          }).toList() ??
          [];

      emit(state.copyWith(
        detailPostModelObj: state.detailPostModelObj?.copyWith(
          detailPostCommentItemList: comments,
        ),
        isLoading: false,
      ));
    }
  }

  void _onGetListCommentPostError() {
    debugPrint('Error fetching detail post');
  }

  FutureOr<void> _callGetListCommentRepliesPost(
    GetListPostCommentRepliesEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.getListCommentReplies(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        postId: event.postId,
      ).then((value) {
        getListCommentPostResp = value;
        _onGetListCommentPostRepliesSuccess(value, event.postId, emit);
        event.onListPostCommentRepliesSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetListCommentPostRepliesError();
        event.onListPostCommentRepliesError?.call();
      });
    } catch (e) {
      debugPrint('Error loading detail post: $e');
      _onGetDetailPostError();
      event.onListPostCommentRepliesError?.call();
    }
  }

  void _onGetListCommentPostRepliesSuccess(
    GetListCommentResp resp,
    String parentCommentId,
    Emitter<DetailPostState> emit,
  ) {
    if (resp.data != null) {
      final replies = resp.data?.map((commentData) {
            return DetailPostCommentItemModel.fromCommentData(
              json: commentData.toJson(),
            );
          }).toList() ??
          [];

      final updatedComments =
          state.detailPostModelObj?.detailPostCommentItemList.map((comment) {
        if (comment.id == parentCommentId) {
          return comment.copyWith(replies: replies);
        }
        return comment;
      }).toList();

      emit(state.copyWith(
        detailPostModelObj: state.detailPostModelObj?.copyWith(
          detailPostCommentItemList: updatedComments,
        ),
      ));
    }
  }

  void _onGetListCommentPostRepliesError() {
    debugPrint('Error fetching detail post');
  }

  FutureOr<void> _callPostComment(
    PostCommentEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();
      String commentText = event.parentCommentId.isEmpty
          ? state.commentController?.text ?? ''
          : state.replyController?.text ?? '';

      if (commentText.trim().isEmpty) {
        event.onPostCommentError?.call();
        return;
      }

      var postCommentReq = event.parentCommentId != ''
          ? PostCommentReq(
              content: commentText.trim(),
              parentCommentId: event.parentCommentId,
            )
          : PostCommentReq(
              content: commentText.trim(),
            );
      await _repository.postComment(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        postId: event.postId,
        requestData: postCommentReq.toJson(),
      ).then((value) {
        postPostCommentResp = value;
        _onPostCommentSuccess(value, emit);
        event.onPostCommentSuccess?.call();
      }).onError((error, stackTrace) {
        _onPostCommentError();
        event.onPostCommentError?.call();
      });
    } catch (e) {
      debugPrint('Error posting comment: $e');
      _onPostCommentError();
      event.onPostCommentError?.call();
    }
  }

  void _onPostCommentSuccess(
    PostCommentResp resp,
    Emitter<DetailPostState> emit,
  ) {
    if (state.commentController != null) {
      state.commentController!.clear();
    }
  }

  void _onPostCommentError() {
    debugPrint('Error posting comment');
  }

  FutureOr<void> _callReactPost(
    ReactPostEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.reactPost(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        postId: event.postId,
      ).then((value) {
        postReactPostResp = value;
        _onReactPostSuccess(emit);
        event.onReactPostSuccess?.call();
      }).onError((error, stackTrace) {
        _onReactPostError();
        event.onReactPostError?.call();
      });
    } catch (e) {
      debugPrint('Error reacting to post: $e');
      _onReactPostError();
      event.onReactPostError?.call();
    }
  }

  void _onReactPostSuccess(Emitter<DetailPostState> emit) {
    final currentModel = state.detailPostModelObj;
    if (currentModel != null) {
      final newIsLiked = !currentModel.isLiked;
      final newReactCount = currentModel.reactCount! + (newIsLiked ? 1 : -1);

      emit(state.copyWith(
        detailPostModelObj: currentModel.copyWith(
          isLiked: newIsLiked,
          reactCount: newReactCount,
        ),
      ));
    }
  }

  void _onReactPostError() {
    debugPrint('Error reacting to post');
  }

  FutureOr<void> _callDeleteComment(
    DeleteCommentEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();

    try {
      bool success = await _repository.deleteComment(
          headers: {'Authorization': 'Bearer $accessToken '}, id: event.id);
      if (success) {
        event.onDeleteCommentEventSuccess?.call();
      } else {
        event.onDeleteCommentEventError?.call();
      }
    } catch (error) {
      event.onDeleteCommentEventError?.call();
    }
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}
