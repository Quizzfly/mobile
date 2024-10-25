part of 'quizzfly_detail_bloc.dart';

/// Represents the state of QuizzflyDetail in the application.
// ignore_for_file: must_be_immutable
class QuizzflyDetailState extends Equatable {
  QuizzflyDetailState(
      {this.quizzflyDetailModelObj,
      this.overviewQuizzflyItemModelObj,
      this.id});
  QuizzflyDetailModel? quizzflyDetailModelObj;
  OverviewQuizzflyItemModel? overviewQuizzflyItemModelObj;
  String? id;

  @override
  List<Object?> get props => [
        quizzflyDetailModelObj,
        overviewQuizzflyItemModelObj,
        id,
      ];

  QuizzflyDetailState copyWith(
      {QuizzflyDetailModel? quizzflyDetailModelObj,
      OverviewQuizzflyItemModel? overviewQuizzflyItemModelObj,
      String? id}) {
    return QuizzflyDetailState(
      quizzflyDetailModelObj:
          quizzflyDetailModelObj ?? this.quizzflyDetailModelObj,
      overviewQuizzflyItemModelObj:
          overviewQuizzflyItemModelObj ?? this.overviewQuizzflyItemModelObj,
      id: id ?? this.id,
    );
  }
}
