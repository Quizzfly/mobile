import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';

/// This class is used in the [recent_activities_grid_item_widget] screen.
// ignore_for_file: must_be_immutable
class RecentActivitiesGridItemModel extends Equatable {
  RecentActivitiesGridItemModel(
      {this.title, this.date, this.imagePath, this.id}) {
    title = title ?? "Untitled";
    date = date ?? "16/11/2024";
    imagePath = imagePath ?? ImageConstant.imgNotFound;
    id = id ?? "";
  }
  String? title;
  String? date;
  String? imagePath;
  String? id;
  RecentActivitiesGridItemModel copyWith({
    String? title,
    String? date,
    String? imagePath,
    String? id,
  }) {
    return RecentActivitiesGridItemModel(
      title: title ?? this.title,
      date: date ?? this.date,
      imagePath: imagePath ?? this.imagePath,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [title, date, imagePath, id];
}
