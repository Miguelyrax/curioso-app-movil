import 'dart:convert';

import 'package:curioso_app/core/constants/constants.dart';
import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/user/data/datasource/user_data_source.dart';
import 'package:curioso_app/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
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
  final url=Uri.parse('${Constants.baseURL}/api/auth/');
  final urlRegister=Uri.parse('${Constants.baseURL}/api/auth/register');
  final urlRenew=Uri.parse('${Constants.baseURL}/api/auth/renew');
  final headers={
      'Content-type':'application/json',
  };
  const token='123';
  final headersRenew={
      'Content-type':'application/json',
      'x-token':token
  };
  final body = {
    'email':'miguel@albanez.com',
    'password':'123456',
  };
  final bodyRegister = {
    'email':'miguel@albanez.com',
    'password':'123456',
    'name':'123'
  };
  void setUpMockStorage()=>when(()=>mockStorage.write(key: 'token', value: user.token))
        .thenAnswer((_) async => Future<void>.value()
  );
  void setUpMockStorageRenews()=>when(()=>mockStorage.read(key: 'token'))
        .thenAnswer((_) async => token
  );
  void setUpMockHttpClient()=>when(()=>mockHttpClient.post(url,headers: headers, body:json.encode(body)))
        .thenAnswer((_) async => http.Response(fixture('user.json'),200)
  );
  void setUpMockHttpClientRegister()=>when(()=>mockHttpClient.post(urlRegister,headers: headers, body:json.encode(bodyRegister)))
        .thenAnswer((_) async => http.Response(fixture('user.json'),200)
  );
  group('login', () {
    test(
      "should perform a POST login request on a URL",
      () async {
        setUpMockHttpClient();
        setUpMockStorage();
        await datasource.login('miguel@albanez.com', '123456');

        verify(()=>mockHttpClient.post(url,headers:headers, body:json.encode(body)));
        verify(()=>mockStorage.write(key: 'token', value: user.token));
      },
    );
    test(
      "should perform a POST login request on a URL are equal",
      () async {
        setUpMockHttpClient();
        setUpMockStorage();
        final result = await datasource.login('miguel@albanez.com', '123456');
        expect(result, equals(user));

      },
    );
    test(
      "should throw a serverException when the response code is 500",
      () async {
        when(()=>mockHttpClient.post(url,headers: headers, body:json.encode(body))).thenAnswer((_) async => http.Response('Server error',500));
          final call=datasource.login('miguel@albanez.com', '123456');
          expect(()async=>await call, throwsA(isA<ServerException>()));
      },
    );

  });
  
  group('register', () {
    test(
      "should perform a POST register request on a URL",
      () async {
        setUpMockHttpClientRegister();
        setUpMockStorage();
        await datasource.register('miguel@albanez.com', '123456','123');
        verify(()=>mockHttpClient.post(urlRegister,headers:headers,body:json.encode(bodyRegister)));

      },
    );
    test(
      "should perform a POST register request on a URL are equal",
      () async {
        setUpMockHttpClientRegister();
        setUpMockStorage();
        final result = await datasource.register('miguel@albanez.com', '123456', '123');
        expect(result, equals(user));

      },
    );
    test(
      "should throw a serverException when the response code is 500 of register",
      () async {
        when(()=>mockHttpClient.post(urlRegister,headers: headers, body:json.encode(bodyRegister)))
        .thenAnswer((_) async => http.Response('Server error',500));
        final call=datasource.register('miguel@albanez.com', '123456','123');
        expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );

  });
  group('renew', () {
    test(
      "should perform a GET renew request on a URL",
      () async {
        setUpMockStorageRenews();
        when(()=>mockHttpClient.get(
          urlRenew,
          headers: headersRenew,))
          .thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        setUpMockStorage();
        await datasource.renew();
        verify(()=>mockHttpClient.get(urlRenew,headers:headersRenew));

      },
    );
    test(
      "should perform a GET renew request on a URL are equal",
      () async {
        setUpMockStorageRenews();
        when(()=>mockHttpClient.get(
          urlRenew,
          headers: headersRenew,)).thenAnswer((_) async => http.Response(fixture('user.json'),200)
        );
        setUpMockStorage();
        final result = await datasource.renew();
        expect(result, equals(user));

      },
    );
    test(
      "should throw a serverException when the response code is 500 of renew",
      () async {
        setUpMockStorageRenews();
        when(()=>mockHttpClient.get(
          urlRenew,
          headers: headersRenew,)).thenAnswer((_) async => http.Response('Server error',500));
          final call=datasource.renew();
          expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );

  });
  group('group name', () {
      const id ='123';
      final data = json.encode( {"ok":true});
      final url=Uri.parse('${Constants.baseURL}/api/survey/$id');
      void setUpMockProfile()=>when(()=>mockHttpClient.put(url,headers: headersRenew))
        .thenAnswer((_) async => http.Response(data,200));
    test(
      "should perfom PUT changeprofile on a url",
      () async {
        setUpMockStorageRenews();
        setUpMockProfile();
        await datasource.changeProfile(id);
        verify(()=>mockHttpClient.put(url,headers: headersRenew));
      },
    );
    test(
      "should return data when the response status is 200",
      () async {
        setUpMockStorageRenews();
        setUpMockProfile();
        final result = await datasource.changeProfile(id);
        expect(result,equals(true));
      },
    );
    test(
      "should return ServerException when the response status is 500 or other",
      () async {
        setUpMockStorageRenews();
        when(()=>mockHttpClient.put(url,headers: headersRenew))
        .thenAnswer((_) async => http.Response('Error',500));
        final call =  datasource.changeProfile(id);
        expect(()async=>await call,throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('recovery password', () {
    const email ='123';
    const code =123;
    final url = Uri.parse('${Constants.baseURL}/api/auth/send/recovery');
    final dataResp = json.encode({'ok':true});
    void setUpMockHttpClient()=>when(()=>mockHttpClient.post(url,headers: headers))
        .thenAnswer((_) async => http.Response(dataResp,200));
    test(
      "should perfomr Post on a url",
      () async {
        setUpMockHttpClient();
        await datasource.recoveryPassword(email, code);
        verify(()=>mockHttpClient.post(url,headers: headers));
      },
    );
    test(
      "should return data when the response status is 200",
      () async {
        setUpMockHttpClient();
        final result = await datasource.recoveryPassword(email, code);
        expect(result, equals(true));
      },
    );

    test(
      "should return ServerExeption when the response status is 500 or other",
      () async {
        when(()=>mockHttpClient.post(url,headers: headers))
        .thenAnswer((invocation) async=> http.Response('Error',500));
        final call = datasource.recoveryPassword(email, code);
        expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));  
      },
    );
  });
    group('send email', () {
    const email ='123';
    final url = Uri.parse('${Constants.baseURL}/api/auth/send');
    final dataResp = json.encode({'ok':true});
    void setUpMockHttpClient()=>when(()=>mockHttpClient.post(url,headers: headers))
        .thenAnswer((_) async => http.Response(dataResp,200));
    test(
      "should perfomr Post on a url",
      () async {
        setUpMockHttpClient();
        await datasource.sendEmail(email);
        verify(()=>mockHttpClient.post(url,headers: headers));
      },
    );
    test(
      "should return data when the response status is 200",
      () async {
        setUpMockHttpClient();
        final result = await datasource.sendEmail(email);
        expect(result, equals(true));
      },
    );

    test(
      "should return ServerExeption when the response status is 500 or other",
      () async {
        when(()=>mockHttpClient.post(url,headers: headers))
        .thenAnswer((invocation) async=> http.Response('Error',500));
        final call = datasource.sendEmail(email);
        expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));  
      },
    );
  });
  group('edit user', () {
    const name = '123';
    const password = '123';
    final data = json.encode({"ok":true});
    final cuerpo = json.encode({
      "name":name,
      "password":password
    });
    final url = Uri.parse('${Constants.baseURL}/api/user/');
    void setUpMockHttp()=>when(()=>mockHttpClient.put(url,headers: headersRenew,body: cuerpo))
    .thenAnswer((_)async=>http.Response(data,200));
    test(
      "should return data when the response status is 200",
      () async {
        setUpMockStorageRenews();
        setUpMockHttp();
        final result = await datasource.editUser(name, password);
        expect(result, equals(true));
      },
    );
    test(
      "should return serverexception when the response status is 500 or other",
      () async {
        setUpMockStorageRenews();
        when(()=>mockHttpClient.put(url,headers: headersRenew,body: cuerpo))
        .thenAnswer((_)async=>http.Response('Error',500));
        final call = datasource.editUser(name, password);
        expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
  
}
