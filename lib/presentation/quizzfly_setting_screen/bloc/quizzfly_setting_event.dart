part of 'quizzfly_setting_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///QuizzflySetting widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class QuizzflySettingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the QuizzflySetting widget is first created.
class QuizzflySettingInitialEvent extends QuizzflySettingEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox
// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable
class ChangeVisibilityEvent extends QuizzflySettingEvent {
  final String? value;

  ChangeVisibilityEvent({this.value});

  @override
  List<Object?> get props => [value];
}

class PickImageEvent extends QuizzflySettingEvent {
  final dynamic imagePath;

  PickImageEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class UpdateSettingsEvent extends QuizzflySettingEvent {
  UpdateSettingsEvent({this.onUpdateSettingsEventSuccess});
  Function? onUpdateSettingsEventSuccess;
  @override
  List<Object?> get props => [onUpdateSettingsEventSuccess];
}
