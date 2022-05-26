import 'dart:convert';

import 'package:curioso_app/features/instruments/data/models/detail_model.dart';
import 'package:curioso_app/features/instruments/data/models/favourites_model.dart';
import 'package:curioso_app/features/instruments/data/models/historical_data_model.dart';
import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';

abstract class InstrumentRemoteDataSource{
  Future<List<InstrumentModel>> getInstruments();
  Future<HistorialDataModel> getHistoricalData(String symbol);
  Future<DetailModel> getDetailInstrument(String symbol);
  Future<List<FavouritesModel>> getFavourites();
  Future<FavouritesModel> postFavourites(String id);
  Future<bool> deleteFavourite(String id);
}

class InstrumentRemoteDataSourceImpl extends InstrumentRemoteDataSource{
  final http.Client client;
  final FlutterSecureStorage storage;

  InstrumentRemoteDataSourceImpl(this.client, this.storage);
  @override
  Future<List<InstrumentModel>> getInstruments() async{
    final url = Uri.parse('${Constants.baseURL}/api/instrument/');
    final resp= await client.get(url,headers: {
      'Content-Type':'application/json'
    });
    if (resp.statusCode == 200) {
      List<InstrumentModel> lista=[];
      final List<dynamic> data =json.decode(const Utf8Decoder().convert(resp.bodyBytes)) ;
      for (var element in data) {
        Map<String,dynamic> map = element;
        lista.add(InstrumentModel.fromJson(map));
      }
      return lista;
    } else {
     throw ServerException();
    }
  }
  @override
  Future<HistorialDataModel> getHistoricalData(String symbol) async{
    final url = Uri.parse('${Constants.baseURL}/api/instrument/historicalData/$symbol/D');
    final resp= await client.get(url,headers: {
      'Content-Type':'application/json'
    });
    if (resp.statusCode == 200) {
      final dynamic data =json.decode(const Utf8Decoder().convert(resp.bodyBytes)) ;
      Map<String,dynamic> map = data;
      final historicalData=HistorialDataModel.fromJson(map);
      return historicalData;
    } else {
     throw ServerException();
    }
  }
  @override
  Future<DetailModel> getDetailInstrument(String symbol) async{
    final url = Uri.parse('${Constants.baseURL}/api/instrument/detailInstrument/$symbol');
    final resp= await client.get(url,headers: {
      'Content-Type':'application/json'
    });
    if (resp.statusCode == 200) {
      final dynamic data =json.decode(const Utf8Decoder().convert(resp.bodyBytes)) ;
      Map<String,dynamic> map = data;
      final DetailModel detail=DetailModel.fromJson(map);
      return detail;
    } else {
     throw ServerException();
    }
  }

  @override
  Future<List<FavouritesModel>> getFavourites() async{
    
    final token=await storage.read(key: 'token');
    final url = Uri.parse('${Constants.baseURL}/api/favorito/');
    final resp= await client.get(url,headers: {
      'Content-Type':'application/json',
      'x-token':token.toString()
    });
    if (resp.statusCode == 200) {
      List<FavouritesModel> favoritos=[];
      final List<dynamic> data =json.decode(const Utf8Decoder().convert(resp.bodyBytes)) ;
      for (var favorito in data) { 
      Map<String,dynamic> map = favorito;
      final FavouritesModel detail=FavouritesModel.fromJson(map);
      favoritos.add(detail);

      }
      return favoritos;
    } else {
     throw ServerException();
    }
  }

  @override
  Future<FavouritesModel> postFavourites(String id) async{
    final token=await storage.read(key: 'token');
    final url = Uri.parse('${Constants.baseURL}/api/favorito/$id');
    final resp= await client.post(url,headers: {
      'Content-Type':'application/json',
      'x-token':token.toString()
    });
    print(resp.statusCode);
    print(id);
    if (resp.statusCode == 200) {
      final Map<String,dynamic> map =json.decode(const Utf8Decoder().convert(resp.bodyBytes)) ;
      final FavouritesModel detail=FavouritesModel.fromJson(map);
      return detail;
    } else {
     throw ServerException();
    }
  }
  
  @override
  Future<bool> deleteFavourite(String id) async{
    final token=await storage.read(key: 'token');
    final url = Uri.parse('${Constants.baseURL}/api/favorito/$id');
    final resp= await client.delete(url,headers: {
      'Content-Type':'application/json',
      'x-token':token.toString()
    });
    print(resp.statusCode);
    if (resp.statusCode == 200) {
      return true;
    } else {
     throw ServerException();
    }
  }

}