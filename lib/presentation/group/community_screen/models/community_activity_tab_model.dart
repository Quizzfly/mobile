import 'package:equatable/equatable.dart';
import 'community_list_item_model.dart';

/// This class is used in the [community_activity_tab_page] screen.
// ignore_for_file: must_be_immutable
class CommunityActivityTabModel extends Equatable {
  CommunityActivityTabModel({this.communityListItemList = const []});
  List<CommunityListItemModel> communityListItemList;

  CommunityActivityTabModel copyWith({
    List<CommunityListItemModel>? communityListItemList,
  }) {
    return CommunityActivityTabModel(
      communityListItemList:
          communityListItemList ?? this.communityListItemList,
    );
  }

  @override
  List<Object?> get props => [communityListItemList];
}
