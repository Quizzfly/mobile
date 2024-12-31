import 'package:equatable/equatable.dart';
import 'notification_model.dart';
import 'list_group_item_model.dart';
import 'recent_activities_grid_item_model.dart';

/// This class is used in the [home_initial_page] screen.
// ignore_for_file: must_be_immutable
class HomeInitialModel extends Equatable {
  HomeInitialModel(
      {this.listGroupItemList = const [],
      this.recentActivitiesGridItemList = const [],
      this.notificationItemList = const [],
      this.unReadCount});
  List<ListGroupItemModel> listGroupItemList;
  List<RecentActivitiesGridItemModel> recentActivitiesGridItemList;
  List<NotificationModel> notificationItemList;
  int? unReadCount;
  HomeInitialModel copyWith({
    List<ListGroupItemModel>? listGroupItemList,
    List<RecentActivitiesGridItemModel>? recentActivitiesGridItemList,
    List<NotificationModel>? notificationItemList,
    int? unReadCount,
  }) {
    return HomeInitialModel(
        listGroupItemList: listGroupItemList ?? this.listGroupItemList,
        recentActivitiesGridItemList:
            recentActivitiesGridItemList ?? this.recentActivitiesGridItemList,
        notificationItemList: notificationItemList ?? this.notificationItemList,
        unReadCount: unReadCount ?? this.unReadCount);
  }

  @override
  List<Object?> get props => [
        listGroupItemList,
        recentActivitiesGridItemList,
        notificationItemList,
        unReadCount
      ];
}
