part of 'community_bloc.dart';

/// Represents the state of Community in the application.
// ignore_for_file: must_be_immutable
class CommunityState extends Equatable {
  CommunityState(
      {this.commentInputFieldController,
      this.postInputFieldController,
      this.communityActivityTabModelObj,
      this.communityModelObj});
  TextEditingController? commentInputFieldController;
  TextEditingController? postInputFieldController;
  CommunityModel? communityModelObj;
  CommunityActivityTabModel? communityActivityTabModelObj;
  @override
  List<Object?> get props => [
        commentInputFieldController,
        postInputFieldController,
        communityActivityTabModelObj,
        communityModelObj
      ];
  CommunityState copyWith({
    TextEditingController? commentInputFieldController,
    TextEditingController? postInputFieldController,
    CommunityActivityTabModel? communityActivityTabModelObj,
    CommunityModel? communityModelObj,
  }) {
    return CommunityState(
      commentInputFieldController:
          commentInputFieldController ?? this.commentInputFieldController,
      postInputFieldController:
          postInputFieldController ?? this.postInputFieldController,
      communityActivityTabModelObj:
          communityActivityTabModelObj ?? this.communityActivityTabModelObj,
      communityModelObj: communityModelObj ?? this.communityModelObj,
    );
  }
}
