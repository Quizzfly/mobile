part of 'change_password_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ChangePassword widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the ChangePassword widget is first created.
class ChangePasswordInitialEvent extends ChangePasswordEvent {
  @override
  List<Object?> get props => [];
}
