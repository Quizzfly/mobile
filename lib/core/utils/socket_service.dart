import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class QuizStartedData {
  final String questionId;
  final List<Map<String, String>> answers;
  final String quizType;
  final int timeLimit;
  // final int numberQuestion;
  QuizStartedData({
    required this.questionId,
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
  late IO.Socket notificationSocket;
  bool _isRoomInitialized = false;
  bool _isNotificationInitialized = false;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  void initializeRoomSocket() {
    if (!_isRoomInitialized) {
      socket = IO.io('https://api.quizzfly.site/rooms', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.onConnect((_) {
        debugPrint('Room Socket Connected');
      });

      socket.onDisconnect((_) {
        debugPrint('Room Socket Disconnected');
      });

      // Original room socket events
      socket.on('quizStarted', (data) {
        if (data != null && data['question'] != null) {
          try {
            final quizData = QuizStartedData.fromJson(data);
            _lastQuizData = quizData;
            if (!_quizStartedController.isClosed) {
              _quizStartedController.add(quizData);
            }
          } catch (e) {
            debugPrint('Error handling quizStarted: $e');
          }
        }
      });
      socket.on('roomCanceled', (data) {
        if (data != null &&
            data['message'] != null &&
            !_roomCanceledController.isClosed) {
          _roomCanceledController.add(data['message'].toString());
        }
      });
      _isRoomInitialized = true;
    }
  }

  void initializeNotificationSocket() {
    if (!_isNotificationInitialized) {
      notificationSocket =
          IO.io('https://api.quizzfly.site/notifications', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      notificationSocket.onConnect((_) {
        debugPrint('Notification Socket Connected');
      });

      notificationSocket.onDisconnect((_) {
        debugPrint('Notification Socket Disconnected');
      });

      notificationSocket.on('notification', (data) {
        if (data != null) {
          try {
            // Parse notification data
            if (data is Map<String, dynamic>) {
              final notification = data['notification'];
              if (notification != null &&
                  notification is Map<String, dynamic>) {
                final content = notification['content'] as String?;
                final agent = notification['agent'] as Map<String, dynamic>?;
                final type = notification['type'] as String?;

                if (content != null) {
                  _notificationController.add({
                    'content': content,
                    'agent': agent,
                    'type': type,
                  }.toString());
                }
              }
            }
          } catch (e) {
            debugPrint('Error handling notification: $e');
          }
        }
      });

      _isNotificationInitialized = true;
    }
  }

  void initializeSocket() {
    initializeRoomSocket();
    initializeNotificationSocket();
  }

  void disconnect() {
    if (_isRoomInitialized) {
      socket.disconnect();
      _isRoomInitialized = false;
    }
    if (_isNotificationInitialized) {
      notificationSocket.disconnect();
      _isNotificationInitialized = false;
    }

    if (!_quizStartedController.isClosed) _quizStartedController.close();
    if (!_roomCanceledController.isClosed) _roomCanceledController.close();
    if (!_notificationController.isClosed) _notificationController.close();
    _lastQuizData = null;
  }

  bool get isRoomConnected => _isRoomInitialized && socket.connected;
  bool get isNotificationConnected =>
      _isNotificationInitialized && notificationSocket.connected;

  // Existing properties
  QuizStartedData? _lastQuizData;
  QuizStartedData? get lastQuizData => _lastQuizData;

  final _quizStartedController = StreamController<QuizStartedData>.broadcast();
  Stream<QuizStartedData> get onQuizStarted => _quizStartedController.stream;

  final _roomCanceledController = StreamController<String>.broadcast();
  Stream<String> get onRoomCanceled => _roomCanceledController.stream;

  final _notificationController = StreamController<String>.broadcast();
  Stream<String> get onNotification => _notificationController.stream;
}
