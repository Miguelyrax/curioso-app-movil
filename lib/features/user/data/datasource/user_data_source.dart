
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/user_model.dart';

abstract class UserDataSource{
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
}

class UserDataSourceImpl extends UserDataSource{
  final http.Client client;

  UserDataSourceImpl(this.client);
  @override
  Future<UserModel> login(String email, String password)async {
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
      return user;
    }
    
    else{
      throw ServerException();
    }
  }
  @override
  Future<UserModel> register(String email, String password, String name)async {
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
      return user;
    }else if(resp.statusCode==404){
      throw  DatabaseFailure(resp.body[1]);
    }else{
      throw ServerException();
    }
  }

}