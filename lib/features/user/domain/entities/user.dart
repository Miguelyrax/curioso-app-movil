

import 'package:equatable/equatable.dart';

class User extends Equatable{
    const User({
        required this.name,
        required this.email,
        required this.token,
        required this.status,
    });

    final String name;
    final String email;
    final String token;
    final bool status;

  @override
  List<Object?> get props => [
    name,
    email,
    token,
    status,
  ];

    // factory User.fromJson(Map<String, dynamic> json) => User(
    //     name: json["name"],
    //     email: json["email"],
    //     token: json["token"],
    //     status: json["status"],
    // );

    // Map<String, dynamic> toJson() => {
    //     "name": name,
    //     "email": email,
    //     "token": token,
    //     "status": status,
    // };
}
