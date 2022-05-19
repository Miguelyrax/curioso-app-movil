import 'dart:io';

import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:curioso_app/features/quiz/data/models/answer_model.dart';
import 'package:curioso_app/features/quiz/data/models/question_model.dart';
import 'package:curioso_app/features/quiz/data/models/quiz_model.dart';
import 'package:curioso_app/features/quiz/data/models/riesgo_model.dart';
import 'package:curioso_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockQuizDataSource extends Mock implements QuizRemoteDataSource{}
void main() {
  late MockQuizDataSource mockQuizDataSource;
  late QuizRepositoryImpl repository;

  setUp(() {
    mockQuizDataSource = MockQuizDataSource();
    repository = QuizRepositoryImpl(mockQuizDataSource);
  });
  const answer= AnswerModel(
    id: '123',
    description:'123'
  );
  const question= QuestionModel(
    id: '123',
    title:'123',
    answer: [answer]
  );
  const quiz= QuizModel(
    id: '123',
    name: '123',
    questions: [question]
  );

  group('Quiz', () {
    test(
      "should return data when the call to data source is sucess",
      () async {
        when(mockQuizDataSource.getQuiz)
        .thenAnswer((_) async => quiz);
        final result = await repository.getQuiz();
        verify(mockQuizDataSource.getQuiz);
        expect(result, equals(const Right(quiz)));
      },
    );
    test(
      "should return server failure when the call to datasource is unsuccessful",
      () async {
        when(mockQuizDataSource.getQuiz).thenThrow(ServerException());
        final result = await repository.getQuiz();
        expect(result, equals(const Left(ServerFailure('Error'))));
      },
    );

    test(
      "should return connection failure when the device connection has no data",
      () async {
        when(mockQuizDataSource.getQuiz).thenThrow(const SocketException(''));
        final result = await repository.getQuiz();
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });


  group('Riesgo', () {
    const map ={
    "123":'123',
    "456":'456'
  };
  const data = RiesgoModel(
    id: '123',
    name: '123',
    description: '123',
    icon: '123'
  );
    test(
      "should return data when the call to datasource is sucess",
      () async {
        when(()=>mockQuizDataSource.getProfile(map))
        .thenAnswer((_) async => data);
        final result = await repository.getRiesgo(map);
        verify(()=>mockQuizDataSource.getProfile(map));
        expect(result, equals(const Right(data)));
      },
    );

    test(
      "should return Server Faiulure when the call to datasorce is unsuccessful",
      () async {
        when(()=>mockQuizDataSource.getProfile(map))
        .thenThrow(ServerException());
        final result = await repository.getRiesgo(map);
        expect(result, equals(const Left(ServerFailure('Error'))));
      },
    );

    test(
      "should return Connection Failure when the device has no internet",
      () async {
        when(()=>mockQuizDataSource.getProfile(map))
        .thenThrow(const SocketException(''));
        final result = await repository.getRiesgo(map);
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });
}
