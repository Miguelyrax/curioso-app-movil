import 'dart:convert';

import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';

abstract class InstrumentRemoteDataSource{
  Future<List<InstrumentModel>> getInstruments();
}

class InstrumentRemoteDataSourceImpl extends InstrumentRemoteDataSource{
  final http.Client client;

  InstrumentRemoteDataSourceImpl(this.client);
  @override
  Future<List<InstrumentModel>> getInstruments() async{
    
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
}