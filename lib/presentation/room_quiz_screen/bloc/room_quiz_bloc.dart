import 'dart:async';
import 'dart:ui';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/quiz_grid_item_model.dart';
import '../models/room_quiz_model.dart';
part 'room_quiz_event.dart';
part 'room_quiz_state.dart';

class RoomQuizBloc extends Bloc<RoomQuizEvent, RoomQuizState> {
  final SocketService _socketService = SocketService();

  RoomQuizBloc(super.initialState) {
    on<RoomQuizInitialEvent>(_onInitialize);
    on<QuizStartedEvent>(_onQuizStarted);
    on<QuizItemTappedEvent>(_onQuizItemTapped);
    on<AnswerResponseEvent>(_onAnswerResponse);
    on<ResultAnswerEvent>(_onResultAnswer);
    on<NextQuestionEvent>(_onNextQuestion);
    on<QuizTimeoutEvent>(_onQuizTimeout);

    _socketService.initializeSocket();
    _initializeQuizSubscription();
    _initializeAnswerResponseSubscription();
    _initializeResultAnswerSubscription();
    _initializeNextQuestionSubscription();
  }

  void _initializeQuizSubscription() {
    _socketService.onQuizStarted.listen(
      (quizData) => add(QuizStartedEvent(quizData.answers, quizData.questionId,
          quizData.quizType, quizData.timeLimit)),
      onError: (error) {
        print('Error in RoomQuizBloc: $error');
      },
    );
    final lastQuizData = _socketService.lastQuizData;
    if (lastQuizData != null) {
      add(QuizStartedEvent(lastQuizData.answers, lastQuizData.questionId,
          lastQuizData.quizType, lastQuizData.timeLimit));
    }
  }

  void _onInitialize(
    RoomQuizInitialEvent event,
    Emitter<RoomQuizState> emit,
  ) async {
    emit(
      state.copyWith(
        roomQuizModelObj: state.roomQuizModelObj?.copyWith(
          quizGridItemList: fillQuizGridItemList(),
        ),
      ),
    );
  }

  void _onQuizStarted(
    QuizStartedEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    final int numberOfItems =
        event.quizType.toUpperCase() == 'TRUE_FALSE' ? 2 : 4;

    final updatedQuizGridItemList = List.generate(
      numberOfItems,
      (index) {
        String content;
        String id;

        if (event.quizType.toUpperCase() == 'TRUE_FALSE') {
          content = index == 0 ? 'True' : 'False';
          id = index < event.answers.length
              ? event.answers[index]['id']?.toString() ?? ''
              : 'tf_$index';
        } else {
          final answer = event.answers[index];
          content = answer['content']?.toString() ?? '';
          id = answer['id']?.toString() ?? '';
        }

        return QuizGridItemModel(
          id: id,
          textAnswer: content,
          backgroundColor: getColorForIndex(index),
          isSelected: false,
        );
      },
    );

    final updatedModel = RoomQuizModel(
      questionId: event.questionId,
      quizGridItemList: updatedQuizGridItemList,
      quizType: event.quizType,
      timeLimit: event.timeLimit,
    );

    emit(state.copyWith(roomQuizModelObj: updatedModel));
  }

  Color getColorForIndex(int index) {
    final colors = [
      appTheme.indigo700,
      appTheme.redA700,
      appTheme.yellowA400,
      appTheme.lightGreen700,
    ];
    return colors[index % colors.length];
  }

  void _onQuizItemTapped(
    QuizItemTappedEvent event,
    Emitter<RoomQuizState> emit,
  ) async {
    if (state.roomQuizModelObj?.quizGridItemList == null ||
        event.index >= state.roomQuizModelObj!.quizGridItemList.length) {
      return;
    }
    emit(state.copyWith(isTimerPaused: true));

    final selectedItem = state.roomQuizModelObj!.quizGridItemList[event.index];
    final updatedList = state.roomQuizModelObj!.quizGridItemList.map((item) {
      if (state.roomQuizModelObj!.quizGridItemList.indexOf(item) ==
          event.index) {
        return item.copyWith(isSelected: true);
      }
      return item.copyWith(isSelected: false);
    }).toList();

    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(isLoading: true));

    final roomPin = PrefUtils().getRoomPin();
    _socketService.socket.emit('answerQuestion', {
      'roomPin': roomPin,
      'answerId': selectedItem.id,
      'questionId': state.roomQuizModelObj?.questionId,
    });

    emit(state.copyWith(
      roomQuizModelObj: state.roomQuizModelObj?.copyWith(
        quizGridItemList: updatedList,
      ),
      isLoading: false,
    ));
  }

  void _onAnswerResponse(
    AnswerResponseEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    emit(state.copyWith(isWaiting: event.isWaiting));
  }

  void _initializeAnswerResponseSubscription() {
    _socketService.socket.on('answerQuestion', (data) {
      if (data['message'] == 'Waiting...') {
        add(AnswerResponseEvent(isWaiting: true));
      } else {
        add(AnswerResponseEvent(isWaiting: false));
      }
    });
  }

  void _initializeResultAnswerSubscription() {
    _socketService.socket.on('resultAnswer', (data) {
      add(ResultAnswerEvent(
        correct: data['correct'] as bool,
        totalScore: data['total_score'] as int,
      ));
    });
  }

  void _onResultAnswer(
    ResultAnswerEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    emit(state.copyWith(
      isWaiting: false,
      showResult: true,
      isCorrect: event.correct,
      totalScore: event.totalScore,
    ));
  }

  List<QuizGridItemModel> fillQuizGridItemList() {
    if (state.roomQuizModelObj?.quizType?.toUpperCase() == 'TRUE_FALSE') {
      return List.generate(
        2,
        (index) => QuizGridItemModel(
          id: state.roomQuizModelObj?.quizGridItemList[index].id,
          backgroundColor: getColorForIndex(index),
          textAnswer: index == 0 ? 'True' : 'False',
          isSelected: false,
        ),
      );
    } else {
      final images = [
        ImageConstant.imgTriangle,
        ImageConstant.imgCircle,
        ImageConstant.imgSquare,
        ImageConstant.imgRhombus
      ];
      final colors = [
        appTheme.indigo700,
        appTheme.redA700,
        appTheme.yellowA400,
        appTheme.lightGreen700,
      ];

      return List.generate(
        images.length,
        (index) => QuizGridItemModel(
          id: state.roomQuizModelObj?.quizGridItemList[index].id,
          backgroundColor: colors[index],
          textAnswer:
              state.roomQuizModelObj?.quizGridItemList[index].textAnswer,
          isSelected: false,
        ),
      );
    }
  }

  void _initializeNextQuestionSubscription() {
    _socketService.socket.on('nextQuestion', (data) {
      if (data != null && data is Map<String, dynamic>) {
        add(NextQuestionEvent(data));
      }
    });
  }

  void _onNextQuestion(
    NextQuestionEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    emit(state.copyWith(
      showResult: false,
      isCorrect: null,
    ));
    final questionData = event.questionData['question'] as Map<String, dynamic>;
    final answers = (questionData['answers'] as List)
        .map((answer) => answer as Map<String, dynamic>)
        .toList();

    add(QuizStartedEvent(
      answers,
      questionData['id'] as String,
      questionData['quiz_type'] as String,
      questionData['time_limit'] as int,
    ));
  }

  void _onQuizTimeout(
    QuizTimeoutEvent event,
    Emitter<RoomQuizState> emit,
  ) async {
    bool hasSelectedAnswer = state.roomQuizModelObj?.quizGridItemList
            .any((item) => item.isSelected) ??
        false;

    emit(state.copyWith(isTimeUp: true));
    emit(state.copyWith(
      isWaiting: false,
      showResult: true,
      isCorrect: hasSelectedAnswer ? state.isCorrect : false,
    ));
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
