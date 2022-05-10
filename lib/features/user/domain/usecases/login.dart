
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

class Login extends UseCase<User,UserParams>{
  final UserRepository repository;

  Login(this.repository);
  @override
  Future<Either<Failure, User>> execute(UserParams params) async{
    return  repository.login(params.email,params.password); 
  }

}

class UserParams {
  final String email;
  final String password;

  UserParams(
    {
    required this.email, 
    required this.password
    }
  );
}