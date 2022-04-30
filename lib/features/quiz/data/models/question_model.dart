import 'dart:convert';

import 'package:curioso_app/features/quiz/data/models/answer_model.dart';
import 'package:curioso_app/features/quiz/domain/entities/question.dart';

class QuestionModel extends Question{
    const QuestionModel({
        required String id,
        required String title,
        required List<AnswerModel> answer,
    }) : super(
      id: id,
        title: title,
        answer: answer,
    );

    

    factory QuestionModel.fromJson(String str) => QuestionModel.fromMap(json.decode(str));


    factory QuestionModel.fromMap(Map<String, dynamic> json) => QuestionModel(
        id: json["_id"],
        title: json["title"],
        answer: List<AnswerModel>.from(json["answer"].map((x) => AnswerModel.fromMap(x))),
    );

}
