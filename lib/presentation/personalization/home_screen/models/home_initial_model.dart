import 'package:equatable/equatable.dart';
import 'grid_label_item_model.dart';
import 'recent_activities_grid_item_model.dart';

/// This class is used in the [home_initial_page] screen.
// ignore_for_file: must_be_immutable
class HomeInitialModel extends Equatable {
  HomeInitialModel(
      {this.gridLabelItemList = const [],
      this.recentActivitiesGridItemList = const []});
  List<GridLabelItemModel> gridLabelItemList;
  List<RecentActivitiesGridItemModel> recentActivitiesGridItemList;
  HomeInitialModel copyWith({
    List<GridLabelItemModel>? gridLabelItemList,
    List<RecentActivitiesGridItemModel>? recentActivitiesGridItemList,
  }) {
    return HomeInitialModel(
      gridLabelItemList: gridLabelItemList ?? this.gridLabelItemList,
      recentActivitiesGridItemList:
          recentActivitiesGridItemList ?? this.recentActivitiesGridItemList,
    );
  }

  @override
  List<Object?> get props => [gridLabelItemList, recentActivitiesGridItemList];
}
