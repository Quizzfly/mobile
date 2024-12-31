part of 'forgot_password_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ForgotPassword widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class ForgotPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the ForgotPassword widget is first created.
class ForgotPasswordInitialEvent extends ForgotPasswordEvent {
  @override
  List<Object?> get props => [];
}

///Event that is dispatched when the user calls the http://103.161.96.76:3000/api/v1/auth/forgot-password API.
// ignore_for_file: must_be_immutable
class CreateForgotPasswordEvent extends ForgotPasswordEvent {
  CreateForgotPasswordEvent(
      {this.onCreateForgotPasswordEventSuccess,
      this.onCreateForgotPasswordEventError});
  Function? onCreateForgotPasswordEventSuccess;
  Function? onCreateForgotPasswordEventError;
  @override
  List<Object?> get props =>
      [onCreateForgotPasswordEventSuccess, onCreateForgotPasswordEventError];
}
