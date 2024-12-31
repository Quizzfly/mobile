import 'dart:async';
import 'package:equatable/equatable.dart';
import '../../../../../data/models/detail_quizzfly/get_detail_quizzfly_resp.dart';
import '../../../../../data/models/list_question/get_list_question_resp.dart';
import '../../../../../data/repository/repository.dart';
import '../../../../../core/app_export.dart';
import '../models/overview_quizzfly_item_model.dart';
import '../models/quiz_list_item_model.dart';
import '../models/quizzfly_detail_model.dart';
part 'quizzfly_detail_event.dart';
part 'quizzfly_detail_state.dart';

/// A bloc that manages the state of a QuizzflyDetail according to the event that is dispatched to it.
class QuizzflyDetailBloc
    extends Bloc<QuizzflyDetailEvent, QuizzflyDetailState> {
  QuizzflyDetailBloc(super.initialState) {
    on<QuizzflyDetailInitialEvent>(_onInitialize);
    on<FetchQuizzflyDetailEvent>(_callGetQuizzflyDetail);
    on<FetchGetListQuestionsEvent>(_callListQuestion);
  }
  final PrefUtils _prefUtils = PrefUtils();

  final _repository = Repository();

  var getDetailQuizzflyResp = GetDetailQuizzflyResp();

  var getListQuestionsResp = GetListQuestionsResp();
  _onInitialize(
    QuizzflyDetailInitialEvent event,
    Emitter<QuizzflyDetailState> emit,
  ) async {
    if (state.id != null) {
      add(FetchQuizzflyDetailEvent(state.id!));
      add(FetchGetListQuestionsEvent(state.id!));
    }
    // Get user data from PrefUtils
    final username = _prefUtils.getUsername();
    final name = _prefUtils.getName();
    final avatar = _prefUtils.getAvatar();

    emit(
      state.copyWith(
        quizzflyDetailModelObj: state.quizzflyDetailModelObj?.copyWith(
          username: username,
          name: name,
          avatar: avatar,
        ),
      ),
    );
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
          overviewQuizzflyItemList: fillOverviewItemList(),
          title: resp.data?.title ?? 'Untitled',
          description: resp.data?.description ?? 'No description',
          coverImage: resp.data?.coverImage ?? ImageConstant.imgNotFound,
        ),
      ),
    );
  }

  List<OverviewQuizzflyItemModel> fillOverviewItemList() {
    return [
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions"),
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions"),
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions"),
      OverviewQuizzflyItemModel(ten: "10", questions: "Questions")
    ];
  }

  void _onGetQuizzflyDetailError() {}

  FutureOr<void> _callListQuestion(
    FetchGetListQuestionsEvent event,
    Emitter<QuizzflyDetailState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.listQuestions(headers: {
        'Authorization': 'Bearer $accessToken',
      }, id: event.id).then((value) async {
        getListQuestionsResp = value;
        _onGetListQuestionSuccess(value, emit);
      }).onError((error, stackTrace) {
        _onGetListQuestionError();
      });
    } catch (e) {
      _onGetListQuestionError();
    }
  }

  void _onGetListQuestionSuccess(
    GetListQuestionsResp resp,
    Emitter<QuizzflyDetailState> emit,
  ) {
    try {
      final questionItems = resp.data?.asMap().entries.map((entry) {
            return QuizListItemModel.fromQuestionData(
              json: entry.value.toJson(),
              index: entry.key,
            );
          }).toList() ??
          [];

      emit(state.copyWith(
        quizzflyDetailModelObj: state.quizzflyDetailModelObj?.copyWith(
          quizListItemList: questionItems,
        ),
      ));
    } catch (e) {
      _onGetListQuestionError();
    }
  }

  void _onGetListQuestionError() {
  }
}
