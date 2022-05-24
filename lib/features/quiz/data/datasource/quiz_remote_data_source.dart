
import 'dart:convert';

import 'package:curioso_app/features/quiz/data/models/quiz_model.dart';
import 'package:curioso_app/features/quiz/data/models/riesgo_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
abstract class QuizRemoteDataSource{
  Future<QuizModel> getQuiz();
  Future<RiesgoModel> getProfile(Map<String,dynamic> data);
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource{
  final http.Client client;

  QuizRemoteDataSourceImpl(this.client);
  @override
  Future<QuizModel> getQuiz() async{
    final url = Uri.parse('${Constants.baseURL}/api/survey');
    final resp= await client.get(url,headers: {
      'Content-Type':'application/json'
    });
    if (resp.statusCode == 200) {
      final QuizModel data = QuizModel.fromMap(json.decode(const Utf8Decoder().convert(resp.bodyBytes)));
      return data;
    } else {
     throw ServerException();
    }
  }
  @override
  Future<RiesgoModel> getProfile(Map<String,dynamic> data) async{
    final url = Uri.parse('${Constants.baseURL}/api/survey');
    final resp= await client.put(url,headers: {
      'Content-Type':'application/json'
    },
    body: jsonEncode(data));
    if (resp.statusCode == 200) {
      print(resp.body);
      final RiesgoModel data = RiesgoModel.fromJson(json.decode(const Utf8Decoder().convert(resp.bodyBytes)));
      return data;
    } else {
     throw ServerException();
    }
  }

}