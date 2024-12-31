import 'package:equatable/equatable.dart';
import 'notification_model.dart';
import 'grid_label_item_model.dart';
import 'recent_activities_grid_item_model.dart';

/// This class is used in the [home_initial_page] screen.
// ignore_for_file: must_be_immutable
class HomeInitialModel extends Equatable {
  HomeInitialModel(
      {this.gridLabelItemList = const [],
      this.recentActivitiesGridItemList = const [],
      this.notificationItemList = const [],
      this.unReadCount});
  List<GridLabelItemModel> gridLabelItemList;
  List<RecentActivitiesGridItemModel> recentActivitiesGridItemList;
  List<NotificationModel> notificationItemList;
  int? unReadCount;
  HomeInitialModel copyWith({
    List<GridLabelItemModel>? gridLabelItemList,
    List<RecentActivitiesGridItemModel>? recentActivitiesGridItemList,
    List<NotificationModel>? notificationItemList,
    int? unReadCount,
  }) {
    return HomeInitialModel(
        gridLabelItemList: gridLabelItemList ?? this.gridLabelItemList,
        recentActivitiesGridItemList:
            recentActivitiesGridItemList ?? this.recentActivitiesGridItemList,
        notificationItemList: notificationItemList ?? this.notificationItemList,
        unReadCount: unReadCount ?? this.unReadCount);
  }

  @override
  List<Object?> get props => [
        gridLabelItemList,
        recentActivitiesGridItemList,
        notificationItemList,
        unReadCount
      ];
}
