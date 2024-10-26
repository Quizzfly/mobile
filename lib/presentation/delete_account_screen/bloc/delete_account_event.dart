part of 'delete_account_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///DeleteAccount widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class DeleteAccountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the DeleteAccount widget is first created.
class DeleteAccountInitialEvent extends DeleteAccountEvent {
  @override
  List<Object?> get props => [];
}

// ignore: duplicate_ignore
// ignore: must_be_immutable
class CreateRequestDeleteEvent extends DeleteAccountEvent {
  CreateRequestDeleteEvent({this.onCreateRequestDeleteEventSuccess});
  Function? onCreateRequestDeleteEventSuccess;
  @override
  List<Object?> get props => [onCreateRequestDeleteEventSuccess];
}

// ignore: duplicate_ignore
// ignore: must_be_immutable
class DeleteVerifyDeleteEvent extends DeleteAccountEvent {
  DeleteVerifyDeleteEvent({this.onDeleteVerifyDeleteEventSuccess});
  Function? onDeleteVerifyDeleteEventSuccess;
  @override
  List<Object?> get props => [onDeleteVerifyDeleteEventSuccess];
}

// ignore_for_file: must_be_immutable
class CreateLogoutEvent extends DeleteAccountEvent {
  CreateLogoutEvent({this.onCreateLogoutEventSuccess, this.onCreateLogoutEventError});
  Function? onCreateLogoutEventSuccess;
  Function? onCreateLogoutEventError;
  @override
  List<Object?> get props => [onCreateLogoutEventSuccess,onCreateLogoutEventError];
}
