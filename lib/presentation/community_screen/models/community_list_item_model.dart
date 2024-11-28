import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';

// ignore: must_be_immutable
class CommunityListItemModel extends Equatable {
  CommunityListItemModel({
    this.name,
    this.host,
    this.description,
    this.image,
    this.likeCount,
    this.commentCount,
    this.share,
    this.userOne,
    this.commentInputFieldController,
    this.isLiked = false,
    this.id
  }) {
    name = name ?? "Aarav Sharma";
    host = host ?? "Host";
    description = description ?? "This is what i learned...";
    image = image ?? ImageConstant.imageBackToSchool;
    likeCount = likeCount ?? 16;
    commentCount = commentCount ?? 24;
    share = share ?? "Share";
    userOne = userOne ?? ImageConstant.imageAvatar;
    commentInputFieldController = commentInputFieldController ?? TextEditingController();
    id = id ?? "";
  }

  String? name;
  String? host;
  String? description;
  String? image;
  int? likeCount;
  int? commentCount;
  String? share;
  String? userOne;
  TextEditingController? commentInputFieldController;
  bool isLiked;
  String? id;

  CommunityListItemModel copyWith({
    String? aaravsharma,
    String? host,
    String? description,
    String? image,
    int? likeCount,
    int? commentCount,
    String? share,
    String? userOne,
    TextEditingController? commentInputFieldController,
    bool? isLiked,
    String? id,
  }) {
    return CommunityListItemModel(
      name: name ?? this.name,
      host: host ?? this.host,
      description: description ?? this.description,
      image: image ?? this.image,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      share: share ?? this.share,
      userOne: userOne ?? this.userOne,
      commentInputFieldController: commentInputFieldController ?? this.commentInputFieldController,
      isLiked: isLiked ?? this.isLiked,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
    name,
    host,
    description,
    image,
    likeCount,
    commentCount,
    share,
    userOne,
    commentInputFieldController,
    isLiked,
    id
  ];
}
