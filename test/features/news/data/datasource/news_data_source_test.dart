import 'dart:convert';

import 'package:curioso_app/core/constants/constants.dart';
import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/news/data/datasource/news_datasource.dart';
import 'package:curioso_app/features/news/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}
void main() {
  late NewsDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = NewsDataSourceImpl(mockHttpClient);
  });
  List<NewsModel> lista=[];
  final List<dynamic> data=json.decode(fixture('news.json'));
  for (var element in data) {
    Map<String,dynamic> map = element;
        lista.add(NewsModel.fromJson(map));
  }

  final url=Uri.parse('${Constants.baseURL}/api/instrument/newsGeneral');
  final headers={
      'Content-type':'application/json',
  };
  const symbol='APPL';


  group('getNewsGeneral', () {
    test(
      "should perform a GET newsGeneral request on a URL",
      () async {
        when(()=>mockHttpClient.get(url,headers: headers))
        .thenAnswer((_) async=> http.Response(fixture('news.json'),200));
        await datasource.getNewsGeneral();
        verifyNever(()=>mockHttpClient.get(url,headers: {
          'Content-type':'application/json; charset=utf-8'
        }));
        // final result= await datasource.getNewsGeneral();
        // expect(result, equals(lista));        
      },
    );
    test(
      "should perform a GET newsGeneral request on a URL",
      () async {
        when(()=>mockHttpClient.get(url,headers: headers))
        .thenAnswer((_) async=> http.Response(fixture('news.json'),200));
        final result= await datasource.getNewsGeneral();
        expect(result, equals(lista));        
      },
    );
    test(
      "should throw a serverException when the response code is 500",
      () async {
        when(()=>mockHttpClient.get(url,headers: headers))
        .thenAnswer((_)async => http.Response('Server error', 500));
        final call= datasource.getNewsGeneral;
        expect(()async=>await call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
  group('getNewsSymbol',
  () {

    test(
      "should throw a serverexception when the response code is 500",
      () async {
        when(()=>mockHttpClient.get(Uri.parse('${Constants.baseURL}/api/instrument/newsSymbol/$symbol'),headers: headers))
        .thenAnswer((_) async=> http.Response('Server error',500));
        final call=  datasource.getNewsSymbol(symbol);
        expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
