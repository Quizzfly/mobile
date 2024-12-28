import 'package:equatable/equatable.dart';
import 'quiz_grid_item_model.dart';
import 'users_rank_list_item_model.dart';

/// This class defines the variables used in the [room_quiz_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable
class RoomQuizModel extends Equatable {
  List<QuizGridItemModel> quizGridItemList;
  List<UsersRankListItemModel> usersRankListItem;
  final String? questionId;
  final String? quizType;
  final int? timeLimit;
  // final int? numberQuestion;
  final int? currentQuestionNumber;

  RoomQuizModel({
    this.quizGridItemList = const [],
    this.usersRankListItem = const [],
    this.questionId,
    this.quizType,
    this.timeLimit,
    // this.numberQuestion,
    this.currentQuestionNumber,
  });
  @override
  List<Object?> get props => [
        quizGridItemList,
        usersRankListItem,
        questionId,
        quizType,
        timeLimit,
        // numberQuestion,
        currentQuestionNumber
      ];
  RoomQuizModel copyWith(
      {List<QuizGridItemModel>? quizGridItemList,
      List<UsersRankListItemModel>? usersRankListItem,
      String? questionId,
      String? quizType,
      int? timeLimit,
      // int? numberQuestion,
      int? currentQuestionNumber}) {
    return RoomQuizModel(
        quizGridItemList: quizGridItemList ?? this.quizGridItemList,
        questionId: questionId ?? this.questionId,
        quizType: quizType ?? this.quizType,
        timeLimit: timeLimit ?? this.timeLimit,
        // numberQuestion: numberQuestion ?? this.numberQuestion,
        currentQuestionNumber:
            currentQuestionNumber ?? this.currentQuestionNumber,
        usersRankListItem: usersRankListItem ?? this.usersRankListItem);
  }
}
