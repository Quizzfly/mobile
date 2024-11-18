part of 'leader_board_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///RoomQuiz widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class LeaderBoardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the RoomQuiz widget is first created.
class LeaderBoardInitialEvent extends LeaderBoardEvent {
  @override
  List<Object?> get props => [];
}
