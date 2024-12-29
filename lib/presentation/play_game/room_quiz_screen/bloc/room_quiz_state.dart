part of 'room_quiz_bloc.dart';

class RoomQuizState extends Equatable {
  final RoomQuizModel? roomQuizModelObj;
  final bool isLoading;
  final bool isWaiting;
  final bool showResult;
  final bool? isCorrect;
  final int? totalScore;
  final bool isTimeUp;
  final bool isTimerPaused;
  final bool showLeaderboard;
  final ConnectionStatus? connectionStatus;
  final String? error;

  const RoomQuizState(
      {this.roomQuizModelObj,
      this.isLoading = false,
      this.isWaiting = false,
      this.showResult = false,
      this.isCorrect,
      this.totalScore = 0,
      this.isTimeUp = false,
      this.isTimerPaused = false,
      this.showLeaderboard = false,
      this.connectionStatus = ConnectionStatus.disconnected,
      this.error});

  @override
  List<Object?> get props => [
        roomQuizModelObj,
        isLoading,
        isWaiting,
        showResult,
        isCorrect,
        totalScore,
        isTimeUp,
        isTimerPaused,
        showLeaderboard,
        connectionStatus,
        error,
      ];

  RoomQuizState copyWith({
    RoomQuizModel? roomQuizModelObj,
    bool? isLoading,
    bool? isWaiting,
    bool? showResult,
    bool? isCorrect,
    int? totalScore,
    bool? isTimeUp,
    bool? isTimerPaused,
    bool? showLeaderboard,
    ConnectionStatus? connectionStatus,
    String? error,
  }) {
    return RoomQuizState(
      roomQuizModelObj: roomQuizModelObj ?? this.roomQuizModelObj,
      isLoading: isLoading ?? this.isLoading,
      isWaiting: isWaiting ?? this.isWaiting,
      showResult: showResult ?? this.showResult,
      isCorrect: isCorrect ?? this.isCorrect,
      totalScore: totalScore ?? this.totalScore,
      isTimeUp: isTimeUp ?? this.isTimeUp,
      isTimerPaused: isTimerPaused ?? this.isTimerPaused,
      showLeaderboard: showLeaderboard ?? this.showLeaderboard,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      error: error ?? this.error,
    );
  }
}

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  quizStarted,
  error,
}
