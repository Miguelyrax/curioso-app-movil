import 'dart:convert';

import 'package:curioso_app/core/constants/constants.dart';
import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:curioso_app/features/quiz/data/models/answer_model.dart';
import 'package:curioso_app/features/quiz/data/models/question_model.dart';
import 'package:curioso_app/features/quiz/data/models/quiz_model.dart';
import 'package:curioso_app/features/quiz/data/models/riesgo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import '../../../../fixture/fixture_reader.dart';
class MockHttpClient extends Mock implements http.Client{} 
void main() {
  late MockHttpClient mockHttpClient;
  late QuizRemoteDataSourceImpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = QuizRemoteDataSourceImpl(mockHttpClient);
  });
  const headers ={
    "Content-Type":"application/json"
  };

  group('quiz', () {
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
    final url = Uri.parse('${Constants.baseURL}/api/survey');
    void setUpHttpClient()=>when(()=>mockHttpClient.get(url,headers: headers))
        .thenAnswer((_) async => http.Response(fixture('quiz.json'),200));
    test(
      "should perform Get quiz on a url",
      () async {
        setUpHttpClient();
        await datasource.getQuiz();
        verify(()=>mockHttpClient.get(url,headers: headers));
      },
    );
    test(
      "should return data when the response status is 200",
      () async {
        setUpHttpClient();
        final result = await datasource.getQuiz();
        expect(result, equals(quiz));
      },
    );
    test(
      "should return server failure when the response status is 500 or another",
      () async {
        when(()=>mockHttpClient.get(url,headers: headers))
        .thenAnswer((_) async => http.Response('Error',500));
        final call = datasource.getQuiz();
        expect(()async => await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
  group('Riesgo', () {
    const map ={
    "123":'123',
    "456":'456'
  };
  const data = RiesgoModel(
    id: '626d88807437b48a4e5bdc50',
    name: 'Balanceado',
    description: '',
    icon: null
  );
  final url = Uri.parse('${Constants.baseURL}/api/survey');
  void setUpHttpClient()=>when(()=>mockHttpClient.put(url,headers: headers,body:json.encode(map)))
  .thenAnswer((_) async => http.Response(fixture('riesgo.json'),200));
    
  test(
    "should perform Put on a url",
    () async {
      setUpHttpClient();
      await datasource.getProfile(map);
      verify(()=>mockHttpClient.put(url,headers: headers,body:json.encode(map)));
    },
  );
  test(
    "should return data when the response status is 200",
    () async {
      setUpHttpClient();
      final result = await datasource.getProfile(map);
      expect(result, equals(data));
    },
  );
  test(
    "should return ServerException when the response status is 500 or other",
    () async {
      when(()=>mockHttpClient.put(url,headers: headers,body: json.encode(map)))
      .thenAnswer((_) async => http.Response('Error',500));
      final call =  datasource.getProfile(map);
      expect(()async =>await call, throwsA(const TypeMatcher<ServerException>()));
    },
  );
  
  });
 
}
