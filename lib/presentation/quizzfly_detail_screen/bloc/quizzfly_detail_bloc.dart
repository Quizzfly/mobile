import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/detail_quizzfly/get_detail_quizzfly_resp.dart';
import 'package:quizzfly_application_flutter/data/repository/repository.dart';
import '../../../core/app_export.dart';
import '../models/overview_quizzfly_item_model.dart';
import '../models/quiz_list_item_model.dart';
import '../models/quizzfly_detail_model.dart';
part 'quizzfly_detail_event.dart';
part 'quizzfly_detail_state.dart';

/// A bloc that manages the state of a QuizzflyDetail according to the event that is dispatched to it.
class QuizzflyDetailBloc
    extends Bloc<QuizzflyDetailEvent, QuizzflyDetailState> {
  QuizzflyDetailBloc(QuizzflyDetailState initialState) : super(initialState) {
    on<QuizzflyDetailInitialEvent>(_onInitialize);
    on<FetchQuizzflyDetailEvent>(_callGetQuizzflyDetail);
  }
  final PrefUtils _prefUtils = PrefUtils();

  final _repository = Repository();

  var getDetailQuizzflyResp = GetDetailQuizzflyResp();

  _onInitialize(
    QuizzflyDetailInitialEvent event,
    Emitter<QuizzflyDetailState> emit,
  ) async {
    if (state.id != null) {
      add(FetchQuizzflyDetailEvent(state.id!));
    }
    // Get user data from PrefUtils
    final username = _prefUtils.getUsername();
    final name = _prefUtils.getName();
    final avatar = _prefUtils.getAvatar();

    emit(
      state.copyWith(
        quizzflyDetailModelObj: state.quizzflyDetailModelObj?.copyWith(
          overviewQuizzflyItemList: fillListtenItemList(),
          quizListItemList: fillQuizListItemList(),
          username: username,
          name: name,
          avatar: avatar,
        ),
      ),
    );
  }

  List<OverviewQuizzflyItemModel> fillListtenItemList() {
    return [
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions"),
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions"),
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions"),
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions")
    ];
  }

  List<QuizListItemModel> fillQuizListItemList() {
    return [
      QuizListItemModel(one: "1", tf: "-", quiz: "Quiz"),
      QuizListItemModel(one: "2", tf: "-", quiz: "True or false"),
      QuizListItemModel(one: "3", tf: "-", quiz: "Slide"),
      QuizListItemModel(one: "4", tf: "-", quiz: "Quiz"),
      QuizListItemModel(one: "5", tf: "-", quiz: "True or false"),
    ];
  }

  FutureOr<void> _callGetQuizzflyDetail(
    FetchQuizzflyDetailEvent event,
    Emitter<QuizzflyDetailState> emit,
  ) async {
    await _repository.getDetailQuizzfly(event.id).then((value) async {
      getDetailQuizzflyResp = value;
      _onGetQuizzflyDetailSuccess(value, emit);
    }).onError((error, stackTrace) {
      _onGetQuizzflyDetailError();
    });
  }

  void _onGetQuizzflyDetailSuccess(
    GetDetailQuizzflyResp resp,
    Emitter<QuizzflyDetailState> emit,
  ) {
    emit(
      state.copyWith(
        quizzflyDetailModelObj: state.quizzflyDetailModelObj?.copyWith(
          title: resp.data?.title ?? '',
          description: resp.data?.description ?? '',
          coverImage: resp.data?.coverImage ?? '',
        ),
      ),
    );
  }

  void _onGetQuizzflyDetailError() {}
}
