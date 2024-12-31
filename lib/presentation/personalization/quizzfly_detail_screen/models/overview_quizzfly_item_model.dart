import 'package:equatable/equatable.dart';

/// This class is used in the [listten_item_widget] screen.
// ignore_for_file: must_be_immutable
class OverviewQuizzflyItemModel extends Equatable {
  OverviewQuizzflyItemModel({this.ten, this.questions, this.id}) {
    ten = ten ?? "10";
    questions = questions ?? "Questions";
    id = id ?? "";
  }
  String? ten;
  String? questions;
  String? id;
  OverviewQuizzflyItemModel copyWith({
    String? ten,
    String? questions,
    String? id,
  }) {
    return OverviewQuizzflyItemModel(
      ten: ten ?? this.ten,
      questions: questions ?? this.questions,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [ten, questions, id];
}
