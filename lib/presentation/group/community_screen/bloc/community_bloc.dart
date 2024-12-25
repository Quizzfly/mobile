import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/invite_member/post_invite_member_req.dart';
import '../../../../data/models/list_comment/post_react_post_resp.dart';
import '../../../../data/models/list_post/get_list_post_group_resp.dart';
import '../../../../core/app_export.dart';
import '../../../../data/repository/repository.dart';
import '../models/community_model.dart';
import '../models/community_activity_tab_model.dart';
import '../models/community_list_item_model.dart';

part 'community_event.dart';
part 'community_state.dart';

/// A bloc that manages the state of a Community according to the event that is dispatched to it.
class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final Repository _repository = Repository();
  var getListPostGroupResp = GetListPostGroupResp();
  var postReactPostResp = PostReactPostResp();

  CommunityBloc(super.initialState) {
    on<CommunityInitialEvent>(_onInitialize);
    on<CreateGetCommunityPostsEvent>(_callGetCommunityPosts);
    on<ReactPostEvent>(_callReactPost);
    on<InviteMemberEvent>(_callInviteMember);
  }

  Future<void> _onInitialize(
    CommunityInitialEvent event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          commentInputFieldController: TextEditingController(),
          postInputFieldController: TextEditingController(),
        ),
      );
      add(
        CreateGetCommunityPostsEvent(
          groupId: state.id,
          onGetCommunityPostsSuccess: () {},
        ),
      );

      emit(
        state.copyWith(
          communityActivityTabModelObj: CommunityActivityTabModel(),
        ),
      );
    } catch (e) {
      print('Error initializing community data: $e');
    }
  }

  FutureOr<void> _callGetCommunityPosts(
    CreateGetCommunityPostsEvent event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      String? accessToken = PrefUtils().getAccessToken();
      await Future.delayed(const Duration(seconds: 1));

      await _repository.getListPostGroup(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        id: event.groupId,
      ).then((value) {
        getListPostGroupResp = value;
        _onGetCommunityPostsSuccess(value, emit);
        event.onGetCommunityPostsSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetCommunityPostsError(emit);
        event.onGetCommunityPostsError?.call();
      });
    } catch (e) {
      print('Error loading community posts: $e');
      _onGetCommunityPostsError(emit);
      event.onGetCommunityPostsError?.call();
    }
  }

  void _onGetCommunityPostsSuccess(
    GetListPostGroupResp resp,
    Emitter<CommunityState> emit,
  ) {
    final communityItems = resp.data?.map((postData) {
          return CommunityListItemModel.fromPostData(
            json: postData.toJson(),
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      isLoading: false,
      communityActivityTabModelObj:
          state.communityActivityTabModelObj?.copyWith(
        communityListItemList: communityItems,
      ),
    ));
  }

  void _onGetCommunityPostsError(Emitter<CommunityState> emit) {
    emit(state.copyWith(isLoading: false));
    print('Error fetching community posts');
  }

  FutureOr<void> _callReactPost(
    ReactPostEvent event,
    Emitter<CommunityState> emit,
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
        _onReactPostSuccess(event.postIndex, emit);
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

  void _onReactPostSuccess(int postIndex, Emitter<CommunityState> emit) {
    final currentList =
        state.communityActivityTabModelObj?.communityListItemList ?? [];
    if (currentList.isNotEmpty && postIndex < currentList.length) {
      final updatedList = List<CommunityListItemModel>.from(currentList);
      final currentPost = updatedList[postIndex];
      final newIsLiked = !currentPost.isLiked;

      updatedList[postIndex] = currentPost.copyWith(
        isLiked: newIsLiked,
        likeCount: (currentPost.likeCount ?? 0) + (newIsLiked ? 1 : -1),
      );

      emit(state.copyWith(
        communityActivityTabModelObj:
            state.communityActivityTabModelObj?.copyWith(
          communityListItemList: updatedList,
        ),
      ));
    }
  }

  void _onReactPostError() {
    print('Error reacting to post');
  }

  FutureOr<void> _callInviteMember(
    InviteMemberEvent event,
    Emitter<CommunityState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();
    var postInviteMemberReq = PostInviteMemberReq(emails: event.emails);
    try {
      bool success = await _repository.inviteMember(
          headers: {'Authorization': 'Bearer $accessToken '},
          id: event.groupId,
          requestData: postInviteMemberReq.toJson());
      if (success) {
        event.onInviteMemberSuccess?.call();
      } else {
        event.onInviteMemberError?.call();
      }
    } catch (error) {
      event.onInviteMemberError?.call();
    }
  }
}
