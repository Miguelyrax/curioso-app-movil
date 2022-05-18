import 'dart:convert';

import 'package:curioso_app/features/news/data/models/news_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';

abstract class NewsDatasource{
  Future<List<NewsModel>> getNewsGeneral();
  Future<List<NewsModel>> getNewsSymbol(String symbol);
}

class NewsDataSourceImpl extends NewsDatasource{
  final http.Client client;

  NewsDataSourceImpl(this.client);
  @override
  Future<List<NewsModel>> getNewsGeneral() async{
    final url = Uri.parse('${Constants.baseURL}/api/instrument/newsGeneral');
    final resp= await client.get(url,headers: {
      'Content-type':'application/json'
    });
    if (resp.statusCode == 200) {
      List<NewsModel> lista=[];
      final List<dynamic> data =json.decode(const Utf8Decoder().convert(resp.bodyBytes)) ;
      for (var element in data) { 
        Map<String,dynamic> map = element;
        lista.add(NewsModel.fromJson(map));
      }
      return lista;
    } else {
     throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> getNewsSymbol(String symbol) async{
    final url = Uri.parse('${Constants.baseURL}/api/instrument/newsSymbol/$symbol');
    final resp= await client.get(url,headers: {
      'Content-type':'application/json'
    });
    if (resp.statusCode == 200) {
      List<NewsModel> lista=[];
      final List<dynamic> data =json.decode(const Utf8Decoder().convert(resp.bodyBytes)) ;
      for (var element in data) { 
        Map<String,dynamic> map = element;
        lista.add(NewsModel.fromJson(map));
      }
      return lista;
    } else {
     throw ServerException();
    }
  }
}