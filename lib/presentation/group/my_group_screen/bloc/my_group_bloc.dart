import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/my_group/get_my_group_resp.dart';
import '../../../../../core/app_export.dart';
import '../../../../../data/repository/repository.dart';
import '../../../../data/models/create_group/post_create_group_req.dart';
import '../../../../data/models/upload_file/post_upload_file_resp.dart';
import '../models/my_group_list_item_model.dart';
import '../models/my_group_model.dart';
part 'my_group_event.dart';
part 'my_group_state.dart';

/// A bloc that manages the state of a MyGroup according to the event that is dispatched to it.
class MyGroupBloc extends Bloc<MyGroupEvent, MyGroupState> {
  final _repository = Repository();
  var getMyGroupResp = GetMyGroupsResp();
  final String? accessToken = PrefUtils().getAccessToken();

  MyGroupBloc(super.initialState) {
    on<MyGroupInitialEvent>(_onInitialize);
    on<CreateGetMyGroupEvent>(_callGetMyGroup);
    on<DeleteMyGroupEvent>(_callDeleteMyGroupApi);
    on<JoinGroupEvent>(_callJoinGroup);
    on<CreateGroupEvent>(_callCreateGroup);
  }

  Future<void> _onInitialize(
    MyGroupInitialEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    try {
      add(CreateGetMyGroupEvent(
        onGetMyGroupSuccess: () {},
      ));

      emit(state.copyWith(
        myGroupModelObj: state.myGroupModelObj?.copyWith(
          myGroupListItemList: [],
        ),
      ));
    } catch (e) {
      debugPrint('Error initializing myGroup data: $e');
    }
  }

  FutureOr<void> _callGetMyGroup(
    CreateGetMyGroupEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    try {
      await _repository.getMyGroup(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getMyGroupResp = value;
        _onGetMyGroupSuccess(value, emit);
        event.onGetMyGroupSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetMyGroupError();
        event.onGetMyGroupError?.call();
      });
    } catch (e) {
      debugPrint('Error loading myGroup: $e');
      _onGetMyGroupError();
      event.onGetMyGroupError?.call();
    }
  }

  void _onGetMyGroupSuccess(
    GetMyGroupsResp resp,
    Emitter<MyGroupState> emit,
  ) {
    final myGroupItems = resp.data?.map((item) {
          final formattedDate = _formatDate(item.group?.createdAt ?? "");
          return MyGroupListItemModel.fromMyGroupData(
            json: item.toJson(),
            formattedDate: formattedDate,
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      myGroupModelObj: state.myGroupModelObj?.copyWith(
        myGroupListItemList: myGroupItems,
      ),
    ));
  }

  void _onGetMyGroupError() {
    // Handle error state here
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return "Today";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
      } else {
        final months = (difference.inDays / 30).floor();
        return "$months ${months == 1 ? 'month' : 'months'} ago";
      }
    } catch (e) {
      return dateStr;
    }
  }

  FutureOr<void> _callDeleteMyGroupApi(
    DeleteMyGroupEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    try {
      bool success = await _repository.deleteMyGroup(
          headers: {'Authorization': 'Bearer $accessToken '}, id: event.id);
      if (success) {
        event.onDeleteMyGroupEventSuccess?.call();
      } else {
        event.onDeleteMyGroupEventError?.call();
      }
    } catch (error) {
      event.onDeleteMyGroupEventError?.call();
    }
  }

  FutureOr<void> _callJoinGroup(
    JoinGroupEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    try {
      bool success = await _repository.joinGroup(
        headers: {'Authorization': 'Bearer $accessToken'},
        id: event.groupId,
      );
      if (success) {
        event.onJoinSuccess?.call();
      } else {
        event.onJoinError?.call();
      }
    } catch (e) {
      event.onJoinError?.call();
    }
  }

  FutureOr<void> _callCreateGroup(
    CreateGroupEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    String? imageUrl;

    if (event.background != null && event.background is File) {
      UploadFileResp uploadResp = await _repository.uploadFile(
        file: event.background,
        headers: {},
      );
      imageUrl = uploadResp.data?.url;
    }
    var postCreateGroupReq = PostCreateGroupReq(
      name: event.name ?? '',
      description: event.description ?? '',
      background: imageUrl ?? '',
    );
    try {
      await _repository.createGroup(headers: {
        'Authorization': 'Bearer $accessToken',
      }, requestData: postCreateGroupReq.toJson()).then((value) async {
        event.onCreateGroupSuccess?.call();
      }).onError((error, stackTrace) {
        event.onCreateGroupError?.call();
      });
    } catch (e) {
      debugPrint('Error loading create group: $e');
      event.onCreateGroupError?.call();
    }
  }
}
