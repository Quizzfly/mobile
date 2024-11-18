import 'package:equatable/equatable.dart';
import 'users_rank_list_item_model.dart';

/// This class defines the variables used in the [leader_board_screen],
/// and is typically used to hold data that is passed between different parts of the applicati
// ignore_for_file: must_be_immutable
class LeaderBoardModel extends Equatable {
  LeaderBoardModel({this.usersRankListItem = const []});
  List<UsersRankListItemModel> usersRankListItem;
  LeaderBoardModel copyWith({List<UsersRankListItemModel>? usersRankListItem}) {
    return LeaderBoardModel(
        usersRankListItem: usersRankListItem ?? this.usersRankListItem);
  }

  @override
  List<Object?> get props => [usersRankListItem];
}
