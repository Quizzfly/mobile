part of 'input_nickname_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///InputNickname widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class InputNicknameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the InputNickname widget is first created.
class InputNicknameInitialEvent extends InputNicknameEvent {
  @override
  List<Object?> get props => [];
}

class JoinRoomEvent extends InputNicknameEvent {
  final String pin;
  final String name;

  JoinRoomEvent({required this.pin, required this.name});

  @override
  List<Object?> get props => [pin, name];
}

class SocketErrorEvent extends InputNicknameInitialEvent {
  final String error;

  SocketErrorEvent(this.error);

  @override
  List<Object?> get props => [error];
}
