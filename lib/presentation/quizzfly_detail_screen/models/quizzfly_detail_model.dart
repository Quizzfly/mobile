import 'package:equatable/equatable.dart';
import 'overview_quizzfly_item_model.dart';
import 'quiz_list_item_model.dart';

/// This class defines the variables used in the [quizzfly_detail_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable
class QuizzflyDetailModel extends Equatable {
  QuizzflyDetailModel({
    this.overviewQuizzflyItemList = const [],
    this.quizListItemList = const [],
    this.username,
    this.name,
    this.avatar,
    this.coverImage,
    this.title,
    this.description,
  });

  final List<OverviewQuizzflyItemModel> overviewQuizzflyItemList;
  final List<QuizListItemModel> quizListItemList;
  final String? username;
  final String? name;
  final String? avatar;
  final String? coverImage;
  final String? title;
  final String? description;
  int get quizCount {
    return quizListItemList
        .where((item) => item.questionType?.toLowerCase() == 'quiz')
        .length;
  }

  QuizzflyDetailModel copyWith({
    List<OverviewQuizzflyItemModel>? overviewQuizzflyItemList,
    List<QuizListItemModel>? quizListItemList,
    String? username,
    String? name,
    String? avatar,
    String? coverImage,
    String? title,
    String? description,
  }) {
    return QuizzflyDetailModel(
      overviewQuizzflyItemList:
          overviewQuizzflyItemList ?? this.overviewQuizzflyItemList,
      quizListItemList: quizListItemList ?? this.quizListItemList,
      username: username ?? this.username,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      coverImage: coverImage ?? this.coverImage,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        overviewQuizzflyItemList,
        quizListItemList,
        username,
        name,
        avatar,
        coverImage,
        title,
        description,
      ];
}
