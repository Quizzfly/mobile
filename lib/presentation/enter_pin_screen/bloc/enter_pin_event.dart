part of 'enter_pin_bloc.dart';

abstract class EnterPinEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EnterPinInitialEvent extends EnterPinEvent {
  @override
  List<Object?> get props => [];
}

class JoinRoomEvent extends EnterPinEvent {
  final String pin;
  final String name;

  JoinRoomEvent({required this.pin, required this.name});

  @override
  List<Object?> get props => [pin, name];
}

class SocketConnectedEvent extends EnterPinEvent {
  @override
  List<Object?> get props => [];
}

class SocketErrorEvent extends EnterPinEvent {
  final String error;

  SocketErrorEvent(this.error);

  @override
  List<Object?> get props => [error];
}

class RoomJoinedEvent extends EnterPinEvent {
  @override
  List<Object?> get props => [];
}
