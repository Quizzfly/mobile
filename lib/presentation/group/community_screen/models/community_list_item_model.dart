import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/app_export.dart';

// ignore: must_be_immutable
class CommunityListItemModel extends Equatable {
  CommunityListItemModel({
    this.id,
    this.memberName,
    this.memberAvatar,
    this.host,
    this.description,
    this.image,
    this.likeCount,
    this.commentCount,
    this.commentInputFieldController,
    this.type,
    this.quizzflyId,
    this.quizzflyImage,
    this.quizzflyTitle,
    this.isLiked = false,
  }) {
    id = id ?? "";
    quizzflyId = quizzflyId ?? "";
    memberName = memberName ?? "Aarav Sharma";
    memberAvatar = memberAvatar ?? ImageConstant.imageAvatar;
    host = host ?? "Host";
    description = description ?? "This is what i learned...";
    image = image ?? ImageConstant.imgNotFound;
    likeCount = likeCount ?? 16;
    commentCount = commentCount ?? 24;
    commentInputFieldController =
        commentInputFieldController ?? TextEditingController();
    type = type ?? "Share";
    quizzflyId = quizzflyId ?? "";
    quizzflyImage = quizzflyImage ?? ImageConstant.imgNotFound;
    quizzflyTitle = quizzflyTitle ?? "Untitled";
  }
  String? quizzflyId;
  String? quizzflyImage;
  String? quizzflyTitle;
  String? id;
  String? memberName;
  String? memberAvatar;
  String? host;
  String? description;
  String? image;
  int? likeCount;
  int? commentCount;
  TextEditingController? commentInputFieldController;
  String? type;
  bool isLiked;

  CommunityListItemModel copyWith({
    String? quizzflyId,
    String? quizzflyImage,
    String? quizzflyTitle,
    String? id,
    String? memberName,
    String? memberAvatar,
    String? host,
    String? description,
    String? image,
    int? likeCount,
    int? commentCount,
    String? type,
    TextEditingController? commentInputFieldController,
    bool? isLiked,
  }) {
    return CommunityListItemModel(
      id: id ?? this.id,
      memberName: memberName ?? this.memberName,
      memberAvatar: memberAvatar ?? this.memberAvatar,
      host: host ?? this.host,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      type: type ?? this.type,
      image: image ?? this.image,
      commentInputFieldController:
          commentInputFieldController ?? this.commentInputFieldController,
      isLiked: isLiked ?? this.isLiked,
      quizzflyId: quizzflyId ?? this.quizzflyId,
      quizzflyImage: quizzflyImage ?? this.quizzflyImage,
      quizzflyTitle: quizzflyTitle ?? this.quizzflyTitle,
    );
  }

  factory CommunityListItemModel.fromPostData({
    required Map<String, dynamic> json,
  }) {
    return CommunityListItemModel(
      id: json['id'] as String?,
      memberName: json['member']?['name'] ?? 'Unknown',
      memberAvatar: json['member']?['avatar'],
      host: json['role'] ?? '',
      description: _stripHtmlTags(json['content'] ?? ''),
      likeCount: json['react_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
      type: json['type'] ?? '',
      image: (json['files'] != null && json['files'].isNotEmpty)
          ? json['files'][0]['url']
          : null,
      isLiked: json['is_liked'] ?? false,
      quizzflyId: (json['quizzfly'] != null && json['quizzfly'].isNotEmpty)
          ? json['quizzfly']['id']
          : null,
      quizzflyImage: (json['quizzfly'] != null && json['quizzfly'].isNotEmpty)
          ? json['quizzfly']['cover_image']
          : null,
      quizzflyTitle: (json['quizzfly'] != null && json['quizzfly'].isNotEmpty)
          ? json['quizzfly']['title']
          : null,
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
        host,
        description,
        image,
        likeCount,
        commentCount,
        commentInputFieldController,
        type,
        isLiked,
        quizzflyTitle,
        quizzflyImage,
        quizzflyId
      ];
}
