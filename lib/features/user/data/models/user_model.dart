

import 'package:curioso_app/features/user/domain/entities/user.dart';

class UserModel extends User{
    const UserModel({
        required String name,
        required String email,
        required String token,
        required bool status,
    }) : super(
        name:name,
        email:email,
        token:token,
        status:status
    );


    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        token: json["token"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "token": token,
        "status": status,
    };
}
