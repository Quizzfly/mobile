import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';

// ignore: must_be_immutable
class UsersRankListItemModel extends Equatable {
  UsersRankListItemModel(
      {this.no, this.id, this.imageAvatar, this.nickName, this.score}) {
    id = id ?? "";
    no = no ?? 1;
    imageAvatar = imageAvatar ?? ImageConstant.imageAvatar;
    score = score ?? 0;
    nickName = nickName ?? "Unknown";
  }
  int? no;
  String? imageAvatar;
  String? id;
  String? nickName;
  int? score;
  @override
  List<Object?> get props => [no, id, imageAvatar, nickName, score];

  UsersRankListItemModel copyWith({
    int? no,
    String? imageAvatar,
    String? id,
    String? nickName,
    int? score,
  }) {
    return UsersRankListItemModel(
      id: id ?? this.id,
      no: no ?? this.no,
      nickName: nickName ?? this.nickName,
      imageAvatar: imageAvatar ?? this.imageAvatar,
      score: score ?? this.score,
    );
  }
}
