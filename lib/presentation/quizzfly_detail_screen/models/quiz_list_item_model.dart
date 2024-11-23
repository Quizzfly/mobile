import 'dart:convert';

import 'package:equatable/equatable.dart';

class QuizListItemModel extends Equatable {
  const QuizListItemModel({
    this.id,
    this.questionNumber,
    this.questionType,
    this.questionContent,
    this.timeLimit,
    this.pointMultiplier,
    this.quizType,
  });

  final String? id;
  final String? questionNumber;
  final String? questionType;
  final String? questionContent;
  final String? timeLimit;
  final String? quizType;
  final int? pointMultiplier;

  QuizListItemModel copyWith({
    String? id,
    String? questionNumber,
    String? questionType,
    String? questionContent,
    String? timeLimit,
    int? pointMultiplier,
    String? quizType,
  }) {
    return QuizListItemModel(
      id: id ?? this.id,
      questionNumber: questionNumber ?? this.questionNumber,
      questionType: questionType ?? this.questionType,
      questionContent: questionContent ?? this.questionContent,
      timeLimit: timeLimit ?? this.timeLimit,
      pointMultiplier: pointMultiplier ?? this.pointMultiplier,
      quizType: quizType ?? this.quizType,
    );
  }

  static String? _extractSlideContent(String content) {
    try {
      final Map<String, dynamic> jsonContent = json.decode(content);
      final List<List<dynamic>> columns =
          List<List<dynamic>>.from(jsonContent['columns']);

      for (var column in columns) {
        for (var item in column) {
          if (item['id'] == 1 && item['value'] != null) {
            return item['value'].toString();
          }
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  factory QuizListItemModel.fromQuestionData({
    required Map<String, dynamic> json,
    required int index,
  }) {
    final questionType = json['type'] ?? 'Quiz';
    String? content = json['content'];

    if (questionType.toString().toLowerCase() == 'slide' && content != null) {
      final slideContent = QuizListItemModel._extractSlideContent(content);
      if (slideContent != null) {
        content = slideContent;
      }
    }

    return QuizListItemModel(
      id: json['id'],
      questionNumber: (index + 1).toString(),
      questionType: questionType,
      questionContent: content,
      timeLimit: json['time_limit'],
      pointMultiplier: json['point_multiplier'],
      quizType: json['quiz_type'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        questionNumber,
        questionType,
        questionContent,
        timeLimit,
        pointMultiplier,
        quizType,
      ];
}
