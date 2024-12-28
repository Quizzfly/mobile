import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'detail_post_comment_item_model.dart';
import '../../../../core/app_export.dart';

/// This class defines the variables used in the [detail_post_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore: must_be_immutable
class DetailPostModel extends Equatable {
  DetailPostModel(
      {this.id,
      this.memberName,
      this.memberAvatar,
      this.content,
      this.files,
      this.reactCount,
      this.commentCount,
      this.type,
      this.isLiked = false,
      this.quizzflyId,
      this.quizzflyImage,
      this.quizzflyTitle,
      this.createdAt,
      this.commentController,
      this.detailPostCommentItemList = const []}) {
    id = id ?? "";
    memberName = memberName ?? "Unknown";
    memberAvatar = memberAvatar ?? ImageConstant.imageAvatar;
    content = content ?? "";
    files = files ?? [];
    reactCount = reactCount ?? 0;
    commentCount = commentCount ?? 0;
    type = type ?? "";
    quizzflyId = quizzflyId ?? "";
    quizzflyImage = quizzflyImage ?? ImageConstant.imgNotFound;
    quizzflyTitle = quizzflyTitle ?? "Untitled";
    createdAt = createdAt ?? "";
    commentController = commentController ?? TextEditingController();
  }

  String? id;
  String? memberName;
  String? memberAvatar;
  String? content;
  List<String>? files;
  int? reactCount;
  int? commentCount;
  String? type;
  bool isLiked;
  String? quizzflyId;
  String? quizzflyImage;
  String? quizzflyTitle;
  String? createdAt;
  TextEditingController? commentController;
  List<DetailPostCommentItemModel> detailPostCommentItemList;

  DetailPostModel copyWith(
      {String? id,
      String? memberName,
      String? memberAvatar,
      String? content,
      List<String>? files,
      int? reactCount,
      int? commentCount,
      String? type,
      bool? isLiked,
      String? quizzflyId,
      String? quizzflyImage,
      String? quizzflyTitle,
      String? createdAt,
      TextEditingController? commentController,
      List<DetailPostCommentItemModel>? detailPostCommentItemList}) {
    return DetailPostModel(
      id: id ?? this.id,
      memberName: memberName ?? this.memberName,
      memberAvatar: memberAvatar ?? this.memberAvatar,
      content: content ?? this.content,
      files: files ?? this.files,
      reactCount: reactCount ?? this.reactCount,
      commentCount: commentCount ?? this.commentCount,
      type: type ?? this.type,
      isLiked: isLiked ?? this.isLiked,
      quizzflyId: quizzflyId ?? this.quizzflyId,
      quizzflyImage: quizzflyImage ?? this.quizzflyImage,
      quizzflyTitle: quizzflyTitle ?? this.quizzflyTitle,
      createdAt: createdAt ?? this.createdAt,
      commentController: commentController ?? this.commentController,
      detailPostCommentItemList:
          detailPostCommentItemList ?? this.detailPostCommentItemList,
    );
  }

  factory DetailPostModel.fromPostData(Map<String, dynamic> json) {
    return DetailPostModel(
      id: json['id'] as String?,
      memberName: json['member']?['name'] ?? 'Unknown',
      memberAvatar: json['member']?['avatar'],
      content: _stripHtmlTags(json['content'] ?? ''),
      files: json['files'] != null
          ? List<String>.from(
              json['files'].map((file) => file['url'] as String))
          : [],
      reactCount: json['react_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
      type: json['type'] ?? '',
      isLiked: json['is_liked'] ?? false,
      quizzflyId: json['quizzfly']?['id'],
      quizzflyImage: json['quizzfly']?['cover_image'],
      quizzflyTitle: json['quizzfly']?['title'],
      createdAt: json['created_at'],
    );
  }

  static String _stripHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  @override
  List<Object?> get props => [
        id,
        memberName,
        memberAvatar,
        content,
        files,
        reactCount,
        commentCount,
        type,
        isLiked,
        quizzflyId,
        quizzflyImage,
        quizzflyTitle,
        createdAt,
        commentController,
        detailPostCommentItemList
      ];
}
