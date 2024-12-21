import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/detail_post/get_detail_post_resp.dart';
import 'package:quizzfly_application_flutter/data/models/list_comment/get_list_comment_resp.dart';
import '../../../../core/app_export.dart';
import '../../../../data/repository/repository.dart';
import '../models/detail_post_comment_item_model.dart';
import '../models/detail_post_model.dart';
part 'detail_post_event.dart';
part 'detail_post_state.dart';

/// A bloc that manages the state of a DetailPost according to the event that is dispatched to it.
class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  final Repository _repository = Repository();
  var getDetailPostResp = GetDetailPostResp();
  var getListCommentPostResp = GetListCommentResp();
  DetailPostBloc(super.initialState) {
    on<DetailPostInitialEvent>(_onInitialize);
    on<FetchDetailPostEvent>(_callGetDetailPost);
    on<GetListPostCommentEvent>(_callGetListCommentPost);
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
}
