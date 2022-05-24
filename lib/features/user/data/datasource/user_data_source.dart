
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/user_model.dart';

abstract class UserDataSource{
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<UserModel> renew();
  Future<bool> changeProfile(String id);
  Future<bool> sendEmail(String email);
  Future<bool> recoveryPassword(String email,int code);
}

class UserDataSourceImpl extends UserDataSource{
  final http.Client client;
  final FlutterSecureStorage storage;

  UserDataSourceImpl(this.client, this.storage);
  @override
  Future<UserModel> login(String email, String password)async {
    final data = {
            'email':email,
            'password':password,
          };
    final url = Uri.parse('${Constants.baseURL}/api/auth/');
    final resp=await client.post(url,headers: {
          'Content-type':'application/json'
    },body:json.encode(data));
    if(resp.statusCode==200){
      final UserModel user=UserModel.fromJson(jsonDecode(const Utf8Decoder().convert(resp.bodyBytes)));
      await storage.write(key: 'token', value: user.token);
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
    final url = Uri.parse('${Constants.baseURL}/api/auth/register');
    final resp=await client.post(url,headers: {
          'Content-type':'application/json'
    },body:json.encode(data));
    if(resp.statusCode==200){
      final UserModel user=UserModel.fromJson(jsonDecode(const Utf8Decoder().convert(resp.bodyBytes)));
      await storage.write(key: 'token', value: user.token);
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
    final url = Uri.parse('${Constants.baseURL}/api/auth/renew');
    final resp=await client.get(url,headers: {
          'Content-type':'application/json',
          'x-token': tokenLocal.toString()
    });
    if(resp.statusCode==200){
      final UserModel user=UserModel.fromJson(jsonDecode(const Utf8Decoder().convert(resp.bodyBytes)));
      print(user.profile);
      await storage.write(key: 'token', value: user.token);
      return user;
    }else if(resp.statusCode==401){
      throw  DatabaseFailure(resp.body[1]);
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<bool> changeProfile(String id) async{
    final String? tokenLocal = await storage.read(key: 'token');
    final url = Uri.parse('${Constants.baseURL}/api/survey/$id');
    print(url);
    final resp=await client.put(url,headers: {
          'Content-type':'application/json',
          'x-token': tokenLocal.toString()
    });
    print(resp.statusCode);
    if(resp.statusCode==200){
      return true;
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<bool> recoveryPassword(String email, int code) async{
    final data = {
      "email":email,
      "code":code
    };
    final url = Uri.parse('${Constants.baseURL}/api/auth/send/recovery');
    final resp=await client.post(url,headers: {
          'Content-type':'application/json',
    },
    body: json.encode(data));
    print(url);
    print(resp.statusCode);
    print(resp.body);
    if(resp.statusCode==200){
      return true;
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<bool> sendEmail(String email) async{
    final data = {
      "email":email
    };
    final url = Uri.parse('${Constants.baseURL}/api/auth/send');
    final resp=await client.post(url,headers: {
          'Content-type':'application/json',
    },
    body: json.encode(data));
    if(resp.statusCode==200){
      return true;
    }else{
      throw ServerException();
    }
  }

}