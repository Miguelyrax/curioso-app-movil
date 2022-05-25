
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/user.dart';

class Login extends UseCase<User,UserParams>{
  final UserRepository repository;

  Login(this.repository);
  @override
  Future<Either<Failure, User>> execute(UserParams params) async{
    return  repository.login(params.email!,params.password); 
  }

}

class UserParams extends Equatable{
  final String? email;
  final String password;
  final String? name;

  UserParams(
    {
    this.email, 
    this.name, 
    required this.password
    }
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
    email,
    password,
    name,
  ];
}