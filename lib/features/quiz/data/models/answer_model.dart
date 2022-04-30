import 'dart:convert';
import 'package:curioso_app/features/quiz/domain/entities/answer.dart';

class AnswerModel extends Answer{
    const AnswerModel({
         required String id,
         required String description,
    }) : super(
      id:id,
      description:description
    );

   

    factory AnswerModel.fromJson(String str) => AnswerModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AnswerModel.fromMap(Map<String, dynamic> json) => AnswerModel(
        id: json["_id"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
    };
}
