part of 'leader_board_bloc.dart';

/// Represents the state of Leaderboard in the application.
// ignore_for_file: must_be_immutable
class LeaderBoardState extends Equatable {
  LeaderBoardState({this.leaderBoardModelObj});
  LeaderBoardModel? leaderBoardModelObj;
  @override
  List<Object?> get props => [leaderBoardModelObj];
  LeaderBoardState copyWith({LeaderBoardModel? leaderBoardModelObj}) {
    return LeaderBoardState(
      leaderBoardModelObj: leaderBoardModelObj ?? this.leaderBoardModelObj,
    );
  }
}
