part of 'profile_setting_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Profile Setting widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class ProfileSettingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Profile Setting widget is first created.
class ProfileSettingInitialEvent extends ProfileSettingEvent {
  @override
  List<Object?> get props => [];
}
