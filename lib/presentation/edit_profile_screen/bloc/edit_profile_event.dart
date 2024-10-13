part of 'edit_profile_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///EditProfile widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the EditProfile widget is first created.
class EditProfileInitialEvent extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

class TextFieldChangedEvent extends EditProfileEvent {
  final String username;
  final String name;
  final String email;
  final dynamic imageFile;
  TextFieldChangedEvent(this.username, this.name, this.email, this.imageFile);

  @override
  List<Object> get props => [username, name, email, imageFile];
}

// ignore: must_be_immutable
class CreateLGetUserEvent extends EditProfileEvent {
  CreateLGetUserEvent(
      {this.onCreateLoginEventSuccess, this.onCreateLoginEventError});
  Function? onCreateLoginEventSuccess;
  Function? onCreateLoginEventError;
  @override
  List<Object?> get props =>
      [onCreateLoginEventSuccess, onCreateLoginEventError];
}

class ImagePickedEvent extends EditProfileEvent {
  final dynamic imageFile;

  ImagePickedEvent(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class UpdateProfileEvent extends EditProfileEvent {
  final Function? onSuccess;
  final Function? onError;

  UpdateProfileEvent({this.onSuccess, this.onError});

  @override
  List<Object?> get props => [onSuccess, onError];
}
