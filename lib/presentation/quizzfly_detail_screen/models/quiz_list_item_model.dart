import 'package:equatable/equatable.dart';

/// This class is used in the [quizlist_item_widget] screen.
// ignore_for_file: must_be_immutable
class QuizListItemModel extends Equatable {
  QuizListItemModel({this.one, this.tf, this.quiz, this.id}) {
    one = one ?? "1";
    tf = tf ?? "-";
    quiz = quiz ?? "Quiz";
    id = id ?? "";
  }
  String? one;
  String? tf;
  String? quiz;
  String? id;
  QuizListItemModel copyWith({
    String? one,
    String? tf,
    String? quiz,
    String? id,
  }) {
    return QuizListItemModel(
      one: one ?? this.one,
      tf: tf ?? this.tf,
      quiz: quiz ?? this.quiz,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [one, tf, quiz, id];
}
