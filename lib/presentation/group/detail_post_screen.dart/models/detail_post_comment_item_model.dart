import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';

/// This class is used in the [detail_post_one_item_widget] screen.
// ignore_for_file: must_be_immutable
class DetailPostCommentItemModel extends Equatable {
  DetailPostCommentItemModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.files,
    this.memberName,
    this.memberAvatar,
    this.countReplies,
  }) {
    id = id ?? "";
    createdAt = createdAt ?? "";
    updatedAt = updatedAt ?? "";
    content = content ?? "";
    files = files ?? [];
    memberName = memberName ?? "Unknown";
    memberAvatar = memberAvatar ?? ImageConstant.imageAvatar;
    countReplies = countReplies ?? 0;
  }

  String? id;
  String? createdAt;
  String? updatedAt;
  String? content;
  List<String>? files;
  String? memberName;
  String? memberAvatar;
  int? countReplies;

  DetailPostCommentItemModel copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? content,
    List<String>? files,
    String? memberName,
    String? memberAvatar,
    int? countReplies,
  }) {
    return DetailPostCommentItemModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
      files: files ?? this.files,
      memberName: memberName ?? this.memberName,
      memberAvatar: memberAvatar ?? this.memberAvatar,
      countReplies: countReplies ?? this.countReplies,
    );
  }

  factory DetailPostCommentItemModel.fromCommentData(
      {required Map<String, dynamic> json}) {
    return DetailPostCommentItemModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      content: json['content'] as String?,
      files: json['files'] != null
          ? List<String>.from(
              json['files'].map((file) => file['url'] as String))
          : [],
      memberName: json['member']?['name'] ?? 'Unknown',
      memberAvatar: json['member']?['avatar'] ?? ImageConstant.imageAvatar,
      countReplies: json['count_replies'] as int?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        content,
        files,
        memberName,
        memberAvatar,
        countReplies,
      ];
}
