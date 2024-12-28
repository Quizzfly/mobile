import 'package:equatable/equatable.dart';
import '../../../personalization/library_screen/models/library_list_item_model.dart';
import 'community_list_item_model.dart';

/// This class is used in the [community_activity_tab_page] screen.
// ignore_for_file: must_be_immutable
class CommunityActivityTabModel extends Equatable {
  CommunityActivityTabModel(
      {this.communityListItemList = const [],
      this.libraryListItemList = const []});
  List<CommunityListItemModel> communityListItemList;
  List<LibraryListItemModel> libraryListItemList;
  CommunityActivityTabModel copyWith(
      {List<CommunityListItemModel>? communityListItemList,
      List<LibraryListItemModel>? libraryListItemList}) {
    return CommunityActivityTabModel(
      communityListItemList:
          communityListItemList ?? this.communityListItemList,
      libraryListItemList: libraryListItemList ?? this.libraryListItemList,
    );
  }

  @override
  List<Object?> get props => [communityListItemList, libraryListItemList];
}
