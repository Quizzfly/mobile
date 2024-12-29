import 'dart:async';
import 'dart:ui';
import 'package:equatable/equatable.dart';
import '../../../../../core/app_export.dart';
import '../models/quiz_grid_item_model.dart';
import '../models/room_quiz_model.dart';
import '../models/users_rank_list_item_model.dart';
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
    on<LeaderboardUpdateEvent>(_onLeaderboardUpdate);
    on<QuizFinishedEvent>(_onQuizFinished);
    on<PlayerKickedEvent>(_onPlayerKicked);
    _socketService.initializeSocket();
    _initializeQuizSubscription();
    _initializeAnswerResponseSubscription();
    _initializeResultAnswerSubscription();
    _initializeNextQuestionSubscription();
    _initializeLeaderboardSubscription();
    _initializeQuizFinishedSubscription();
    _initializeRoomCancelSubscription();
  }

  void _initializeQuizSubscription() {
    _socketService.onQuizStarted.listen(
      (quizData) => add(QuizStartedEvent(
        quizData.answers, quizData.questionId,
        quizData.quizType, quizData.timeLimit,
        // quizData.numberQuestion
      )),
      onError: (error) {
        print('Error in RoomQuizBloc: $error');
      },
    );
    final lastQuizData = _socketService.lastQuizData;
    if (lastQuizData != null) {
      add(QuizStartedEvent(
        lastQuizData.answers,
        lastQuizData.questionId,
        lastQuizData.quizType,
        lastQuizData.timeLimit,
        // lastQuizData.numberQuestion
      ));
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
      currentQuestionNumber: state.roomQuizModelObj?.currentQuestionNumber ?? 1,
      // numberQuestion: event.numberQuestion,
    );

    emit(state.copyWith(roomQuizModelObj: updatedModel));
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
      'room_pin': roomPin,
      'answer_id': selectedItem.id,
      'question_id': state.roomQuizModelObj?.questionId,
      'participant_id': PrefUtils().getParticipantId(),
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
        correct: data['is_correct'] as bool,
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

  void _initializeNextQuestionSubscription() {
    _socketService.socket.on('quizStarted', (data) {
      if (data != null && data is Map<String, dynamic>) {
        add(NextQuestionEvent(data));
      }
    });
  }

  void _onNextQuestion(
    NextQuestionEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    final updatedQuestionNumber =
        (state.roomQuizModelObj?.currentQuestionNumber ?? 0) + 1;
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
      // state.roomQuizModelObj!.numberQuestion as int,
    ));
    emit(state.copyWith(
      roomQuizModelObj: state.roomQuizModelObj?.copyWith(
        currentQuestionNumber: updatedQuestionNumber,
      ),
    ));
  }

  void _initializeRoomCancelSubscription() {
    _socketService.onRoomCanceled.listen(
      (message) => add(PlayerKickedEvent(message)),
    );
  }

  void _onPlayerKicked(
    PlayerKickedEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    emit(state.copyWith(
      error: event.reason,
      connectionStatus: ConnectionStatus.error,
    ));
  }

  void _onQuizTimeout(
    QuizTimeoutEvent event,
    Emitter<RoomQuizState> emit,
  ) async {
    bool hasSelectedAnswer = state.roomQuizModelObj?.quizGridItemList
            .any((item) => item.isSelected) ??
        false;
    emit(state.copyWith(
      isTimeUp: true,
      isWaiting: false,
      showResult: true,
      isCorrect: hasSelectedAnswer ? state.isCorrect : false,
    ));
  }

  void _initializeLeaderboardSubscription() {
    _socketService.socket.on('updateLeaderboard', (data) {
      if (data != null && data is Map<String, dynamic>) {
        try {
          final leaderboard = (data['leader_board'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();

          add(LeaderboardUpdateEvent(
            leaderboard,
          ));
        } catch (e) {
          print('Error parsing leaderboard data: $e');
        }
      }
    });
  }

  void _onLeaderboardUpdate(
    LeaderboardUpdateEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    final leaderboardItems = event.leaderboardData.map((playerData) {
      return UsersRankListItemModel(
        id: playerData['socket_id'] ?? '',
        nickName: playerData['nick_name'] ?? '',
        score: playerData['total_score'] ?? 0,
        no: playerData['rank'] ?? 0,
        imageAvatar: ImageConstant.imageAvatar, // Using default avatar
      );
    }).toList();

    emit(state.copyWith(
      roomQuizModelObj: state.roomQuizModelObj?.copyWith(
        usersRankListItem: leaderboardItems,
      ),
      // showLeaderboard: isLastQuestion ? true : false
    ));
  }

  void _initializeQuizFinishedSubscription() {
    _socketService.socket.on('quizFinished', (data) {
      add(QuizFinishedEvent());
    });
  }

  void _onQuizFinished(
    QuizFinishedEvent event,
    Emitter<RoomQuizState> emit,
  ) {
    emit(state.copyWith(
      showLeaderboard: true,
    ));
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
}
