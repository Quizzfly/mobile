part of 'quizzfly_detail_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// QuizzflyDetail widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class QuizzflyDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the QuizzflyDetail widget is first created.
class QuizzflyDetailInitialEvent extends QuizzflyDetailEvent {
  @override
  List<Object?> get props => [];
}

class FetchQuizzflyDetailEvent extends QuizzflyDetailEvent {
  final String id;

  FetchQuizzflyDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// ignore: must_be_immutable
class FetchGetListQuestionsEvent extends QuizzflyDetailEvent {
  final String id;

  FetchGetListQuestionsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
