part of 'waiting_room_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///WaitingRoom widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class WaitingRoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the WaitingRoom widget is first created.
class WaitingRoomInitialEvent extends WaitingRoomEvent {
  @override
  List<Object?> get props => [];
}

class QuizStartedWaitingEvent extends WaitingRoomEvent {
  QuizStartedWaitingEvent();

  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when socket encounters an error
class SocketErrorEvent extends WaitingRoomEvent {
  final String error;

  SocketErrorEvent(this.error);

  @override
  List<Object?> get props => [error];
}
