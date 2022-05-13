import 'dart:convert';

import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/user/data/datasource/user_data_source.dart';
import 'package:curioso_app/features/user/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}
 class FakeUri extends Fake implements Uri {}
void main() {
  late MockHttpClient mockHttpClient;
  late UserDataSourceImpl datasource;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockHttpClient = MockHttpClient();
    datasource = UserDataSourceImpl(mockHttpClient);
  });
  final UserModel user=UserModel.fromJson(jsonDecode(fixture('user.json')));
  final url=Uri.parse('http://localhost:8080/api/auth/');
  final urlRegister=Uri.parse('http://localhost:8080/api/auth/register');
  final headers={
      'Content-type':'application/json; charset=utf-8',
  };
  group('login', () {
    test(
      "should perform a POST login request on a URL",
      () async {
        when(()=>mockHttpClient.post(any(), body: any(named: 'body'))).thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        await datasource.login('miguel@albanez.com', '123456');
        verifyNever(()=>mockHttpClient.post(url,headers:headers));

      },
    );
    test(
      "should perform a POST login request on a URL are equal",
      () async {
        when(()=>mockHttpClient.post(
          url,
          headers: headers,
          body:{
            'email':'miguel@albanez.com',
            'password':'123456',
          })).thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        final result = await datasource.login('miguel@albanez.com', '123456');
        expect(result, equals(user));

      },
    );
    test(
      "should throw a serverException when the response code is 500",
      () async {
        when(()=>mockHttpClient.post(any(), body: any(named: 'body'))).thenAnswer((_) async => http.Response('Server error',500));
          final call=datasource.login('miguel@albanez.com', '123456');
          expect(()async=>await call, throwsA(isA<ServerException>()));
      },
    );

  });
  
  group('register', () {
    test(
      "should perform a POST register request on a URL",
      () async {
        when(()=>mockHttpClient.post(
          urlRegister,
          headers: headers,
          body:{
            'email':'miguel@albanez.com',
            'password':'123456',
            'name':'123'
          })).thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        await datasource.register('miguel@albanez.com', '123456','123');
        verifyNever(()=>mockHttpClient.post(urlRegister,headers:headers));

      },
    );
    test(
      "should perform a POST register request on a URL are equal",
      () async {
        when(()=>mockHttpClient.post(
          urlRegister,
          headers: headers,
          body:{
            'email':'miguel@albanez.com',
            'password':'123456',
            'name':'123',
          })).thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        final result = await datasource.register('miguel@albanez.com', '123456', '123');
        expect(result, equals(user));

      },
    );
    test(
      "should throw a serverException when the response code is 500 of register",
      () async {
        when(()=>mockHttpClient.post(
          urlRegister,
          headers: headers,
          body:{
            'email':'miguel@albanez.com',
            'password':'123456',
            'name':'123'
          })).thenAnswer((_) async => http.Response('Server error',500));
          final call=datasource.register('miguel@albanez.com', '123456','123');
          expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );

  });
  
}
