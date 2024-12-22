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

    // Listen for comment posts
    socket.on('commentPost', (data) {
      if (data is Map && data.isNotEmpty) {
        // Create a new comment model from socket data
        final newComment = DetailPostCommentItemModel(
          id: data['id'],
          content: data['content'],
          createdAt: data['created_at'],
          memberName: data['member']['name'],
          memberAvatar: data['member']['avatar'],
        );

        // Add event to handle new comment
        add(NewCommentReceivedEvent(newComment));
      }
    });
  }

  FutureOr<void> _handleNewComment(
    NewCommentReceivedEvent event,
    Emitter<DetailPostState> emit,
  ) {
    final currentComments = List<DetailPostCommentItemModel>.from(
        state.detailPostModelObj?.detailPostCommentItemList ?? []);

    // Add new comment to the beginning of the list
    currentComments.insert(0, event.comment);

    // Update state with new comment list
    emit(state.copyWith(
      detailPostModelObj: state.detailPostModelObj?.copyWith(
        detailPostCommentItemList: currentComments,
      ),
    ));
  }

  FutureOr<void> _onInitialize(
    DetailPostInitialEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      emit(state.copyWith(
        commentController: TextEditingController(),
      ));

      add(FetchDetailPostEvent(
        groupId: state.groupId!,
        postId: state.postId!,
        onGetDetailPostSuccess: () {},
      ));
    } catch (e) {
      print('Error initializing detail post: $e');
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
      print('Error loading detail post: $e');
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
    print('Error fetching detail post');
  }

  FutureOr<void> _callGetListCommentPost(
    GetListPostCommentEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

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
      print('Error loading detail post: $e');
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
      ));
    }
  }

  void _onGetListCommentPostError() {
    print('Error fetching detail post');
  }

  FutureOr<void> _callPostComment(
    PostCommentEvent event,
    Emitter<DetailPostState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();
      if (state.commentController?.text.trim().isEmpty ?? true) {
        event.onPostCommentError?.call();
        return;
      }

      var postCommentReq = PostCommentReq(
        content: state.commentController?.text.trim() ?? '',
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
      print('Error posting comment: $e');
      _onPostCommentError();
      event.onPostCommentError?.call();
    }
  }

  void _onPostCommentSuccess(
    PostCommentResp resp,
    Emitter<DetailPostState> emit,
  ) {
    // Clear comment input after successful post
    if (state.commentController != null) {
      state.commentController!.clear();
    }
  }

  void _onPostCommentError() {
    print('Error posting comment');
  }

  // In detail_post_bloc.dart, add this to the existing bloc class:

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
      print('Error reacting to post: $e');
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
    print('Error reacting to post');
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}
