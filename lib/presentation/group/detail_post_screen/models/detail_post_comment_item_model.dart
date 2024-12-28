import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';

// ignore: must_be_immutable
class DetailPostCommentItemModel extends Equatable {
  DetailPostCommentItemModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.files,
      this.memberName,
      this.memberAvatar,
      this.countReplies,
      this.replies,
      this.parentCommentId}) {
    id = id ?? "";
    createdAt = createdAt ?? "";
    updatedAt = updatedAt ?? "";
    content = content ?? "";
    files = files ?? [];
    memberName = memberName ?? "Unknown";
    memberAvatar = memberAvatar ?? ImageConstant.imageAvatar;
    countReplies = countReplies ?? 0;
    replies = replies ?? [];
    parentCommentId = parentCommentId ?? "";
  }

  String? id;
  String? createdAt;
  String? updatedAt;
  String? content;
  List<String>? files;
  String? memberName;
  String? memberAvatar;
  int? countReplies;
  List<DetailPostCommentItemModel>? replies;
  String? parentCommentId;
  DetailPostCommentItemModel copyWith(
      {String? id,
      String? createdAt,
      String? updatedAt,
      String? content,
      List<String>? files,
      String? memberName,
      String? memberAvatar,
      int? countReplies,
      List<DetailPostCommentItemModel>? replies,
      String? parentCommentId}) {
    return DetailPostCommentItemModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        content: content ?? this.content,
        files: files ?? this.files,
        memberName: memberName ?? this.memberName,
        memberAvatar: memberAvatar ?? this.memberAvatar,
        countReplies: countReplies ?? this.countReplies,
        replies: replies ?? this.replies,
        parentCommentId: parentCommentId ?? this.parentCommentId);
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
      replies: const [],
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
        replies,
        parentCommentId
      ];
}
