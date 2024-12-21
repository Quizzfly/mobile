import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
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
  CommunityBloc(super.initialState) {
    on<CommunityInitialEvent>(_onInitialize);
    on<CreateGetCommunityPostsEvent>(_callGetCommunityPosts);
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
    try {
      String? accessToken = PrefUtils().getAccessToken();

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
        _onGetCommunityPostsError();
        event.onGetCommunityPostsError?.call();
      });
    } catch (e) {
      print('Error loading community posts: $e');
      _onGetCommunityPostsError();
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
      communityActivityTabModelObj:
          state.communityActivityTabModelObj?.copyWith(
        communityListItemList: communityItems,
      ),
    ));
  }

  void _onGetCommunityPostsError() {
    print('Error fetching community posts');
  }
}
