import 'dart:convert';

import 'package:curioso_app/features/instruments/data/models/detail_model.dart';
import 'package:curioso_app/features/instruments/data/models/historical_data_model.dart';
import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';

abstract class InstrumentRemoteDataSource{
  Future<List<InstrumentModel>> getInstruments();
  Future<HistorialDataModel> getHistoricalData(String symbol);
  Future<DetailModel> getDetailInstrument(String symbol);
}

class InstrumentRemoteDataSourceImpl extends InstrumentRemoteDataSource{
  final http.Client client;

  InstrumentRemoteDataSourceImpl(this.client);
  @override
  Future<List<InstrumentModel>> getInstruments() async{
    print('solicitado');
    final url = Uri.parse('http://localhost:8080/api/instrument/');
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
    final url = Uri.parse('http://localhost:8080/api/instrument/historicalData/$symbol/D');
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
    final url = Uri.parse('http://localhost:8080/api/instrument/detailInstrument/$symbol');
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
}