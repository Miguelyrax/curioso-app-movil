import 'dart:convert';

import 'package:curioso_app/features/quiz/data/models/answer_model.dart';
import 'package:curioso_app/features/quiz/data/models/question_model.dart';
import 'package:curioso_app/features/quiz/data/models/quiz_model.dart';
import 'package:curioso_app/features/quiz/domain/entities/answer.dart';
import 'package:curioso_app/features/quiz/domain/entities/question.dart';
import 'package:curioso_app/features/quiz/domain/entities/quiz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  late QuizModel quizModel;
  late QuestionModel questionModel;
  late AnswerModel answerModel;
 

  setUp(() {
   answerModel=const AnswerModel(
    id: '123',
    description:'123'
  );
  questionModel=QuestionModel(
    id: '123',
    title:'123',
    answer: [answerModel]
  );
  quizModel= QuizModel(
    id: '123',
    name: '123',
    questions: [questionModel]
  );
  });
  

  group('Quiz', () {
    test(
      "shuld be a subclass of Quiz entity",
      () async {
        expect(quizModel,isA<Quiz>());
      },
    );
    test(
      "should return a valid model when the method .fromMap is called",
      () async {
        final Map<String, dynamic> data = json.decode(fixture('quiz.json'));
        final quiz= QuizModel.fromMap(data);
        expect(quizModel, equals(quiz));
      },
    );
  });
  group('Question', () {
    test(
      "should be a subclass of Question Entity",
      () async {
        expect(questionModel, isA<Question>());
      },
    );
    test(
      "should return a valid model when the method frommap is called",
      () async {
        List<QuestionModel> questions=[];
        final List<dynamic> data = json.decode(fixture('quiz.json'))["question"];
        for (var question in data) { 
          Map<String,dynamic> map =question;
          questions.add(QuestionModel.fromMap(map));
        }
        expect(questionModel, equals(questions[0]));
      },
    );
  });
  group('Quiz', () {
    test(
      "shuld be a subclass of Quiz entity",
      () async {
        expect(quizModel,isA<Quiz>());
      },
    );
    test(
      "should return a valid model when the method .fromMap is called",
      () async {
        final Map<String, dynamic> data = json.decode(fixture('quiz.json'));
        final quiz= QuizModel.fromMap(data);
        expect(quizModel, equals(quiz));
      },
    );
  });
  group('Answer', () {
    test(
      "should be a subclass of Answer Entity",
      () async {
        expect(answerModel, isA<Answer>());
      },
    );
    test(
      "should return a valid model when the method frommap is called",
      () async {
        List<AnswerModel> answers=[];
        final List<dynamic> data = json.decode(fixture('quiz.json'))["question"][0]["answer"];
        for (var answer in data) { 
          Map<String,dynamic> map =answer;
          answers.add(AnswerModel.fromMap(map));
        }
        expect(answerModel, equals(answers[0]));
      },
    );
  });
}
