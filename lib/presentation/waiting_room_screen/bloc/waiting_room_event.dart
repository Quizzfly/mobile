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
