part of 'community_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///DeleteAccount widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class CommunityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the DeleteAccount widget is first created.
class CommunityInitialEvent extends CommunityEvent {
  @override
  List<Object?> get props => [];
}