
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../models/user_model.dart';

abstract class UserDataSource{
  Future<UserModel> login(String email, String password);
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
      print(resp.body);
      final UserModel user=UserModel.fromJson(jsonDecode(const Utf8Decoder().convert(resp.bodyBytes)));
      return user;
    }else{
      throw ServerException();
    }
  }

}