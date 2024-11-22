part of 'room_quiz_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///RoomQuiz widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class RoomQuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the RoomQuiz widget is first created.
class RoomQuizInitialEvent extends RoomQuizEvent {
  @override
  List<Object?> get props => [];
}

class QuizItemTappedEvent extends RoomQuizEvent {
  final int index;

  QuizItemTappedEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class QuizStartedEvent extends RoomQuizEvent {
  final List<Map<String, dynamic>> answers;
  final String questionId;
  final String quizType;
  final int timeLimit;
  final int numberQuestion;
  QuizStartedEvent(this.answers, this.questionId, this.quizType, this.timeLimit,
      this.numberQuestion);

  @override
  List<Object?> get props =>
      [answers, questionId, quizType, timeLimit, numberQuestion];
}

class AnswerResponseEvent extends RoomQuizEvent {
  final bool isWaiting;
  final bool hideResult;

  AnswerResponseEvent({
    required this.isWaiting,
    this.hideResult = false,
  });

  @override
  List<Object?> get props => [isWaiting, hideResult];
}

class ResultAnswerEvent extends RoomQuizEvent {
  final bool correct;
  final int totalScore;

  ResultAnswerEvent({
    required this.correct,
    required this.totalScore,
  });

  @override
  List<Object?> get props => [correct, totalScore];
}

class NextQuestionEvent extends RoomQuizEvent {
  final Map<String, dynamic> questionData;

  NextQuestionEvent(this.questionData);

  @override
  List<Object?> get props => [questionData];
}

class QuizTimeoutEvent extends RoomQuizEvent {
  QuizTimeoutEvent();

  @override
  List<Object?> get props => [];
}

class LeaderboardUpdateEvent extends RoomQuizEvent {
  final List<Map<String, dynamic>> leaderboardData;

  LeaderboardUpdateEvent(this.leaderboardData);

  @override
  List<Object?> get props => [leaderboardData];
}
