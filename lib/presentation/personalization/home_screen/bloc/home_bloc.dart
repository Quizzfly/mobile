import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/data/models/notification/get_unread_notification_resp.dart';
import '../../../../data/models/my_group/get_my_group_resp.dart';
import '../../../../data/models/notification/get_list_notification_resp.dart';
import '../../../../data/models/create_group/post_create_group_req.dart';
import '../../../../core/app_export.dart';
import '../../../../data/models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../../../../data/models/upload_file/post_upload_file_resp.dart';
import '../../../../data/repository/repository.dart';
import '../models/list_group_item_model.dart';
import '../models/home_initial_model.dart';
import '../models/home_model.dart';
import '../models/notification_model.dart';
import '../models/recent_activities_grid_item_model.dart';
part 'home_event.dart';
part 'home_state.dart';

/// A bloc that manages the state of a Home according to the event that is dispatched to it.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _repository = Repository();
  var getRecentActivitiesResp = GetLibraryQuizzflyResp();
  final String? accessToken = PrefUtils().getAccessToken();
  var getListNotificationResp = GetListNotificationResp();
  var getUnreadNotificationResp = GetUnreadNotificationResp();
  var getMyGroupResp = GetMyGroupsResp();

  HomeBloc(super.initialState) {
    on<HomeInitialEvent>(_onInitialize);
    on<CreateGetRecentActivitiesEvent>(_callGetRecentActivities);
    on<CreateGroupEvent>(_callCreateGroup);
    on<CreateGetListNotificationEvent>(_callGetListNotification);
    on<CreateUnreadNotificationEvent>(_callGetUnreadNotification);
    on<MarkAllReadNotificationEvent>(_callMarkAllNotification);
    on<MarkReadNotificationEvent>(_callMarkNotification);
    on<CreateGetMyGroupEvent>(_callGetMyGroup);
  }
  _onInitialize(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    add(CreateGetRecentActivitiesEvent());
    add(CreateGetListNotificationEvent());
    add(CreateGetMyGroupEvent());
    add(CreateUnreadNotificationEvent());
    emit(
      state.copyWith(
        homeInitialModelObj: state.homeInitialModelObj?.copyWith(
          listGroupItemList: [],
          recentActivitiesGridItemList: [],
          notificationItemList: [],
        ),
      ),
    );
  }

  FutureOr<void> _callGetRecentActivities(
    CreateGetRecentActivitiesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _repository.getLibraryQuizzfly(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getRecentActivitiesResp = value;
        _onGetRecentActivitiesSuccess(value, emit);
        event.onGetRecentActivitiesSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetRecentActivitiesError();
        event.onGetRecentActivitiesError?.call();
      });
    } catch (e) {
      debugPrint('Error loading recent activities: $e');
      _onGetRecentActivitiesError();
      event.onGetRecentActivitiesError?.call();
    }
  }

  void _onGetRecentActivitiesSuccess(
    GetLibraryQuizzflyResp resp,
    Emitter<HomeState> emit,
  ) {
    final recentActivitiesItems = resp.data?.map((item) {
          final formattedDate = _formatDate(item.createdAt ?? "");
          return RecentActivitiesGridItemModel(
            title: item.title ?? "Untitled",
            date: formattedDate,
            imagePath: item.coverImage ?? ImageConstant.imgNotFound,
            id: item.id ?? "",
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      homeInitialModelObj: state.homeInitialModelObj?.copyWith(
        recentActivitiesGridItemList: recentActivitiesItems,
      ),
    ));
  }

  void _onGetRecentActivitiesError() {
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

  FutureOr<void> _callCreateGroup(
    CreateGroupEvent event,
    Emitter<HomeState> emit,
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

  FutureOr<void> _callGetListNotification(
    CreateGetListNotificationEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _repository.getListNotifications(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getListNotificationResp = value;
        _onGetListNotificationSuccess(value, emit);
        event.onGetListNotificationSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetListNotificationError();
        event.onGetListNotificationError?.call();
      });
    } catch (e) {
      debugPrint('Error loading recent activities: $e');
      _onGetListNotificationError();
      event.onGetListNotificationError?.call();
    }
  }

  void _onGetListNotificationSuccess(
    GetListNotificationResp resp,
    Emitter<HomeState> emit,
  ) {
    final notificationItemList = resp.data?.map((item) {
          final formattedDate = _formatDate(item.createdAt ?? "");
          return NotificationModel(
            name: item.agent?.name ?? "Unnamed",
            date: formattedDate,
            avatar: item.agent?.avatar ?? ImageConstant.imageAvatar,
            id: item.object?.id ?? "",
            notificationType: item.notificationType ?? "",
            isRead: item.isRead ?? false,
            description: item.description ?? "",
            postId: item.object?.postId ?? "",
            targetId: item.targetId ?? "",
            notificationId: item.id ?? "",
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      homeInitialModelObj: state.homeInitialModelObj?.copyWith(
        notificationItemList: notificationItemList,
      ),
    ));
  }

  void _onGetListNotificationError() {
    // Handle error state here
  }
  FutureOr<void> _callGetUnreadNotification(
    CreateUnreadNotificationEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _repository.getUnreadCount(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getUnreadNotificationResp = value;
        _onGetUnreadNotificationSuccess(value, emit);
      }).onError((error, stackTrace) {
        _onGetUnreadNotificationError();
      });
    } catch (e) {
      debugPrint('Error loading recent activities: $e');
      _onGetUnreadNotificationError();
    }
  }

  void _onGetUnreadNotificationSuccess(
    GetUnreadNotificationResp resp,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        homeInitialModelObj:
            state.homeInitialModelObj?.copyWith(unReadCount: resp.dataCount),
      ),
    );
  }

  void _onGetUnreadNotificationError() {}

  FutureOr<void> _callMarkAllNotification(
    MarkAllReadNotificationEvent event,
    Emitter<HomeState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();

    try {
      bool success = await _repository.markRead(
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (success) {
        add(CreateGetListNotificationEvent(
          onGetListNotificationSuccess: () {
            add(CreateUnreadNotificationEvent());
            event.onMarkAllNotificationSuccess?.call();
          },
          onGetListNotificationError: () {
            event.onMarkAllNotificationError?.call();
          },
        ));
      } else {
        event.onMarkAllNotificationError?.call();
      }
    } catch (error) {
      debugPrint('Error marking all notifications as read: $error');
      event.onMarkAllNotificationError?.call();
    }
  }

  FutureOr<void> _callMarkNotification(
    MarkReadNotificationEvent event,
    Emitter<HomeState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();

    try {
      bool success = await _repository.markRead(
          headers: {'Authorization': 'Bearer $accessToken '}, id: event.id);
      if (success) {
        add(
          CreateGetListNotificationEvent(
            onGetListNotificationSuccess: () {
              add(CreateUnreadNotificationEvent());
              event.onMarkNotificationSuccess?.call();
            },
            onGetListNotificationError: () {
              event.onMarkNotificationError?.call();
            },
          ),
        );
      } else {
        event.onMarkNotificationError?.call();
      }
    } catch (error) {
      event.onMarkNotificationError?.call();
    }
  }

  FutureOr<void> _callGetMyGroup(
    CreateGetMyGroupEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

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
    Emitter<HomeState> emit,
  ) {
    final listGroupItemList = resp.data?.map((item) {
          return ListGroupItemModel(
              id: item.group?.id ?? '',
              image: item.group?.background ?? ImageConstant.imgNotFound,
              title: item.group?.name ?? 'Unnamed',
              role: item.role ?? '');
        }).toList() ??
        [];

    emit(state.copyWith(
      homeInitialModelObj: state.homeInitialModelObj?.copyWith(
        listGroupItemList: listGroupItemList,
      ),
    ));
  }

  void _onGetMyGroupError() {
    // Handle error state here
  }
}
