
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/user_model.dart';

abstract class UserDataSource{
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<UserModel> renew();
}

class UserDataSourceImpl extends UserDataSource{
  final http.Client client;
  final FlutterSecureStorage storage;

  UserDataSourceImpl(this.client, this.storage);
  @override
  Future<UserModel> login(String email, String password)async {
    const _storage = FlutterSecureStorage();
    final data = {
            'email':email,
            'password':password,
          };
    final url = Uri.parse('http://localhost:8080/api/auth/');
    final resp=await client.post(url,headers: {
          'Content-type':'application/json; charset=utf-8'
        },body:json.encode(data));
    if(resp.statusCode==200){
      final UserModel user=UserModel.fromJson(jsonDecode(const Utf8Decoder().convert(resp.bodyBytes)));
      await _storage.write(key: 'token', value: user.token);
      return user;
    }
    
    else{
      throw ServerException();
    }
  }
  @override
  Future<UserModel> register(String email, String password, String name)async {
    const _storage = FlutterSecureStorage();
    final data = {
      'email':email,
      'password':password,
      'name':name,
    };
    final url = Uri.parse('http://localhost:8080/api/auth/register');
    final resp=await client.post(url,headers: {
          'Content-type':'application/json; charset=utf-8'
    },body:json.encode(data));
    if(resp.statusCode==200){
      final UserModel user=UserModel.fromJson(jsonDecode(const Utf8Decoder().convert(resp.bodyBytes)));
      await _storage.write(key: 'token', value: user.token);
      return user;
    }else if(resp.statusCode==404){
      throw  DatabaseFailure(resp.body[1]);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<UserModel> renew() async{
    final String? tokenLocal = await storage.read(key: 'token');
    final url = Uri.parse('http://localhost:8080/api/auth/renew');
    final resp=await client.get(url,headers: {
          'Content-type':'application/json',
          'x-token': tokenLocal.toString()
    });
    if(resp.statusCode==200){
      final UserModel user=UserModel.fromJson(jsonDecode(const Utf8Decoder().convert(resp.bodyBytes)));
      await storage.write(key: 'token', value: user.token);
      return user;
    }else if(resp.statusCode==401){
      throw  DatabaseFailure(resp.body[1]);
    }else{
      throw ServerException();
    }
  }

}