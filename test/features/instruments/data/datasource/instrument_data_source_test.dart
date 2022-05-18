import 'dart:convert';
import 'package:curioso_app/core/constants/constants.dart';
import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/instruments/data/datasource/instrument_remote_data_source.dart';
import 'package:curioso_app/features/instruments/data/models/detail_model.dart';
import 'package:curioso_app/features/instruments/data/models/favourites_model.dart';
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
  const token='123';
    const headerToken= {
      'Content-Type':'application/json',
      'x-token':token
    };
  
  void setUpMockStorage()=>when(()=>mockStorage.read(key: 'token'))
        .thenAnswer((_) async => token);
  group('detail', () {
  final data=DetailModel.fromJson(json.decode(fixture('detail.json')));
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
  group('Favourites',(){

    final url = Uri.parse('${Constants.baseURL}/api/favorito/');
    List<FavouritesModel> favoritos=[];
    final List<dynamic> data =json.decode(fixture('favoritos.json')) ;
    for (var favorito in data) { 
      Map<String,dynamic> map = favorito;
      final FavouritesModel detail=FavouritesModel.fromJson(map);
      favoritos.add(detail);
    }
    
    void setUpMockHttpClient()=>when(()=>mockHttpClient.get(url,headers: headerToken))
        .thenAnswer((_) async => http.Response(fixture('favoritos.json'),200));
    
    test(
      "should perform a Get favourites on a url",
      () async {
        setUpMockStorage();
        setUpMockHttpClient();
        await datasource.getFavourites();
        verify(()=>mockHttpClient.get(url,headers: headerToken));
        verify(()=>mockStorage.read(key: 'token'));
      },
    );

    test(
      "should return favourites when response status is 200",
      () async {
        setUpMockStorage();
        setUpMockHttpClient();
        final result = await datasource.getFavourites();
        expect(result, equals(favoritos));
      },
    );

    test(
      "should return ServerFailure when response status is 500 or other",
      () async {
        setUpMockStorage();
        when(()=>mockHttpClient.get(url,headers: headerToken))
        .thenAnswer((_) async => http.Response('Error',500));
        final call =  datasource.getFavourites();
        expect(()async=>call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
  group('Post favourites', (){
    const id='1';
    final urlPost = Uri.parse('${Constants.baseURL}/api/favorito/$id');
    void setUpMockHttpClientPost()=>when(()=>mockHttpClient.post(urlPost,headers: headerToken))
        .thenAnswer((_) async => http.Response(fixture('favorito.json'),200));
    final favorito = FavouritesModel.fromJson(json.decode(fixture('favorito.json')));
      test(
        "should perform a Post favourites on a url",
        () async {
          setUpMockStorage();
          setUpMockHttpClientPost();
          await datasource.postFavourites(id);
          verify(()=>mockHttpClient.post(urlPost,headers: headerToken));
          verify(()=>mockStorage.read(key: 'token'));
        },
      );
      test(
        "should return favourites when response post status is 200",
        () async {
          setUpMockStorage();
          setUpMockHttpClientPost();
          final result = await datasource.postFavourites(id);
          expect(result, equals(favorito));
        },
     );
     test(
      "should return ServerFailure when response status is 500 or other",
      () async {
        setUpMockStorage();
        when(()=>mockHttpClient.post(urlPost,headers: headerToken))
        .thenAnswer((_) async => http.Response('Error',500));
        final call =  datasource.postFavourites(id);
        expect(()async=>call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
