part of 'privacy_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Privacy widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class PrivacyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Privacy widget is first created.
class PrivacyInitialEvent extends PrivacyEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing switch
// ignore_for_file: must_be_immutable
class ChangeSwitchEvent extends PrivacyEvent {
  ChangeSwitchEvent({required this.value});
  bool value;
  @override
  List<Object?> get props => [value];
}

class ChangeSwitch1Event extends PrivacyEvent {
  ChangeSwitch1Event({required this.value});
  bool value;
  @override
  List<Object?> get props => [value];
}

class ChangeSwitch2Event extends PrivacyEvent {
  ChangeSwitch2Event({required this.value});
  bool value;
  @override
  List<Object?> get props => [value];
}

class ChangeSwitch3Event extends PrivacyEvent {
  ChangeSwitch3Event({required this.value});
  bool value;
  @override
  List<Object?> get props => [value];
}

class ChangeSwitch4Event extends PrivacyEvent {
  ChangeSwitch4Event({required this.value});
  bool value;
  @override
  List<Object?> get props => [value];
}

class ChangeSwitch5Event extends PrivacyEvent {
  ChangeSwitch5Event({required this.value});
  bool value;
  @override
  List<Object?> get props => [value];
}

class ChangeSwitch6Event extends PrivacyEvent {
  ChangeSwitch6Event({required this.value});
  bool value;
  @override
  List<Object?> get props => [value];
}
