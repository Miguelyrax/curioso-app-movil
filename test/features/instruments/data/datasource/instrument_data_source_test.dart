import 'dart:convert';
import 'package:curioso_app/core/constants/constants.dart';
import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/instruments/data/datasource/instrument_remote_data_source.dart';
import 'package:curioso_app/features/instruments/data/models/detail_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}  
class MockStorage extends Mock implements FlutterSecureStorage{}  
void main() {
  late MockHttpClient mockHttpClient;
  late MockStorage mockStorage;
  late InstrumentRemoteDataSourceImpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockStorage = MockStorage();
    datasource = InstrumentRemoteDataSourceImpl(
      mockHttpClient,mockStorage
    );
  });
  const symbol='APPL';
  const headers={
      'Content-Type':'application/json'
  };
  final data=DetailModel.fromJson(json.decode(fixture('detail.json')));
  
  group('detail', () {
    final url = Uri.parse('${Constants.baseURL}/api/instrument/detailInstrument/$symbol');
    void setUpMockClientHttp()=>when(()=>mockHttpClient.get(url,headers:headers))
        .thenAnswer((_) async => http.Response(fixture('detail.json'),200));
    void setUpMockClientFailure()=>when(()=>mockHttpClient.get(url,headers:headers))
        .thenAnswer((_) async => http.Response('Error',500));
    test(
      "should perform a GET detail request on a url",
      () async {
        setUpMockClientHttp();
         await datasource.getDetailInstrument(symbol);
        verify(()=>mockHttpClient.get(url,headers:headers));
      },
    );
    test(
      "should return detail when the response status is 200",
      () async {
        setUpMockClientHttp();
        final result = await datasource.getDetailInstrument(symbol);
        expect(result, equals(data));
      },
    );
    test(
      "should trow a ServerExeption when the response code is 500 or other",
      () async {
        setUpMockClientFailure();
        final call = datasource.getDetailInstrument(symbol);
        expect(()async=>await call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
