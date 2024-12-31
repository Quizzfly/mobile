import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';

/// This class is used in the [recent_activities_grid_item_widget] screen.
// ignore_for_file: must_be_immutable
class NotificationModel extends Equatable {
  NotificationModel(
      {this.name,
      this.date,
      this.avatar,
      this.id,
      this.notificationType,
      this.isRead,
      this.targetId,
      this.description,
      this.postId,
      this.notificationId}) {
    name = name ?? "Unnamed";
    date = date ?? "16/11/2024";
    avatar = avatar ?? ImageConstant.imageAvatar;
    id = id ?? "";
    notificationType = notificationType ?? "";
    isRead = isRead ?? false;
    targetId = targetId ?? "";
    postId = postId ?? "";
    description = description ?? "";
    notificationId = notificationId ?? "";
  }
  String? name;
  String? date;
  String? avatar;
  String? id;
  String? notificationType;
  bool? isRead;
  String? targetId;
  String? postId;
  String? description;
  String? notificationId;
  NotificationModel copyWith(
      {String? name,
      String? date,
      String? avatar,
      String? id,
      String? notificationType,
      bool? isRead,
      String? targetId,
      String? postId,
      String? description,
      String? notificationId}) {
    return NotificationModel(
      name: name ?? this.name,
      date: date ?? this.date,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
      notificationType: notificationType ?? this.notificationType,
      isRead: isRead ?? this.isRead,
      targetId: targetId ?? this.targetId,
      postId: postId ?? this.postId,
      description: description ?? this.description,
      notificationId: notificationId ?? this.notificationId,
    );
  }

  @override
  List<Object?> get props => [
        name,
        date,
        avatar,
        id,
        notificationType,
        isRead,
        targetId,
        postId,
        description,
        notificationId
      ];
}
