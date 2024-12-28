import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class QuizStartedData {
  final String questionId;
  final List<Map<String, String>> answers;
  final String quizType;
  final int timeLimit;
  // final int numberQuestion;
  QuizStartedData(
      {required this.questionId,
      required this.answers,
      required this.quizType,
      required this.timeLimit,
      // required this.numberQuestion
      });

  factory QuizStartedData.fromJson(Map<String, dynamic> json) {
    final question = json['question'] as Map<String, dynamic>;
    // final questions = json['questions'] as List;
    final answers = (question['answers'] as List)
        .map((answer) => {
              'id': answer['id'] as String,
              'content': answer['content'] as String,
            })
        .toList();

    return QuizStartedData(
      questionId: question['id'] as String,
      answers: answers,
      quizType: question['quiz_type'] as String,
      timeLimit: question['time_limit'] as int,
      // numberQuestion: questions.length,
    );
  }
}

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;
  bool _isInitialized = false;
  QuizStartedData? _lastQuizData;
  QuizStartedData? get lastQuizData => _lastQuizData;

  // Stream controller for quizStarted events
  final _quizStartedController = StreamController<QuizStartedData>.broadcast();
  Stream<QuizStartedData> get onQuizStarted => _quizStartedController.stream;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  void initializeSocket() {
    if (!_isInitialized) {
      socket = IO.io('https://api.quizzfly.site/rooms', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.onConnect((_) {
      });

      socket.onDisconnect((_) {
      });

      // Listen for quizStarted events
      socket.on('quizStarted', (data) {
        if (data != null && data['question'] != null) {
          try {
            final quizData = QuizStartedData.fromJson(data);
            _lastQuizData = quizData;
            _quizStartedController.add(quizData);
          // ignore: empty_catches
          } catch (e) {
          }
        }
      });
      _isInitialized = true;
    }
  }

  void reEmitLastQuizData() {
    if (_lastQuizData != null) {
      _quizStartedController.add(_lastQuizData!);
    }
  }

  void disconnect() {
    if (_isInitialized) {
      socket.disconnect();
      _isInitialized = false;
      _quizStartedController.close();
      _lastQuizData = null;
    }
  }

  bool get isConnected => _isInitialized && socket.connected;
}
