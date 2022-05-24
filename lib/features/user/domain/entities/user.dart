

import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable{
    const User({
        required this.name,
        required this.email,
        required this.token,
        required this.status,
        this.profile,
    });

    final String name;
    final String email;
    final String token;
    final bool status;
    final Riesgo? profile;

  @override
  List<Object?> get props => [
    name,
    email,
    token,
    status,
  ];

}
