// To parse this JSON data, do
//
//     final quiz = quizFromMap(jsonString);

import 'dart:convert';

import 'package:curioso_app/features/quiz/data/models/question_model.dart';

import '../../domain/entities/quiz.dart';

class QuizModel extends Quiz{
    const QuizModel({
        required String id,
        required String name,
        required List<QuestionModel> questions,
    }) : super(
      id:id,
      name:name,
      questions:questions
    );

    factory QuizModel.fromJson(String str) => QuizModel.fromMap(json.decode(str));


    factory QuizModel.fromMap(Map<String, dynamic> json) => QuizModel(
        id: json["id"],
        name: json["name"],
        questions: List<QuestionModel>.from(json["question"].map((x) => QuestionModel.fromMap(x))),
    );
}


