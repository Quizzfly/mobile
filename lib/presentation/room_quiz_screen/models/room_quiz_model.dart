import 'package:equatable/equatable.dart';
import 'quiz_grid_item_model.dart';

/// This class defines the variables used in the [room_quiz_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable
class RoomQuizModel extends Equatable {
  List<QuizGridItemModel> quizGridItemList;
  final String? questionId;
  final String? quizType;
  final int? timeLimit;
  RoomQuizModel(
      {this.quizGridItemList = const [],
      this.questionId,
      this.quizType,
      this.timeLimit});
  @override
  List<Object?> get props =>
      [quizGridItemList, questionId, quizType, timeLimit];
  RoomQuizModel copyWith({
    List<QuizGridItemModel>? quizGridItemList,
    String? questionId,
    String? quizType,
    int? timeLimit,
  }) {
    return RoomQuizModel(
        quizGridItemList: quizGridItemList ?? this.quizGridItemList,
        questionId: questionId ?? this.questionId,
        quizType: quizType ?? this.quizType,
        timeLimit: timeLimit ?? this.timeLimit);
  }
}
