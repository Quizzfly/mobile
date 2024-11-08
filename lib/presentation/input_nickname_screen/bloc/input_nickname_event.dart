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
