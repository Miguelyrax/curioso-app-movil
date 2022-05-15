import 'dart:convert';

import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/user/data/datasource/user_data_source.dart';
import 'package:curioso_app/features/user/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}
class MockStorage extends Mock implements FlutterSecureStorage{}
 class FakeUri extends Fake implements Uri {}
void main() {
  late MockHttpClient mockHttpClient;
  late MockStorage mockStorage;
  late UserDataSourceImpl datasource;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockHttpClient = MockHttpClient();
    mockStorage = MockStorage();
    datasource = UserDataSourceImpl(mockHttpClient,mockStorage);
  });
  final UserModel user=UserModel.fromJson(jsonDecode(fixture('user.json')));
  final url=Uri.parse('http://localhost:8080/api/auth/');
  final urlRegister=Uri.parse('http://localhost:8080/api/auth/register');
  final urlRenew=Uri.parse('http://localhost:8080/api/auth/renew');
  final headers={
      'Content-type':'application/json; charset=utf-8',
  };
  final headersRenew={
      'Content-type':'application/json',
      'x-token':'token'
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
  group('renew', () {
    test(
      "should perform a GET renew request on a URL",
      () async {
        when(()=>mockHttpClient.get(
          urlRenew,
          headers: headersRenew,)).thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        await datasource.renew();
        verifyNever(()=>mockHttpClient.get(urlRenew,headers:headersRenew));

      },
    );
    test(
      "should perform a GET renew request on a URL are equal",
      () async {
        when(()=>mockHttpClient.get(
          urlRenew,
          headers: headersRenew,)).thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        final result = await datasource.renew();
        expect(result, equals(user));

      },
    );
    test(
      "should throw a serverException when the response code is 500 of renew",
      () async {
        when(()=>mockHttpClient.get(
          urlRenew,
          headers: headersRenew,)).thenAnswer((_) async => http.Response('Server error',500));
          final call=datasource.renew();
          expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );

  });
  
}
