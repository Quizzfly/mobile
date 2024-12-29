import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuizGridItemModel extends Equatable {
  QuizGridItemModel({
    this.textAnswer,
    this.id,
    this.backgroundColor,
    this.isSelected = false,
  }) {
    textAnswer = textAnswer ?? "Default Answer";
    id = id ?? "";
    backgroundColor = backgroundColor ?? Colors.purple;
  }

  String? textAnswer;
  String? id;
  Color? backgroundColor;
  bool isSelected;

  @override
  List<Object?> get props => [textAnswer, id, backgroundColor, isSelected];

  QuizGridItemModel copyWith({
    String? textAnswer,
    String? id,
    Color? backgroundColor,
    bool? isSelected,
  }) {
    return QuizGridItemModel(
      textAnswer: textAnswer ?? this.textAnswer,
      id: id ?? this.id,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
