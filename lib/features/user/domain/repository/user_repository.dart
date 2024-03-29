import 'package:curioso_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class UserRepository{
  Future<Either<Failure,User>> login(String email, String password);
  Future<Either<Failure,User>> register(String email, String password,String name);
  Future<Either<Failure,User>> renew();
  Future<Either<Failure,bool>> changeProfile(String id);
  Future<Either<Failure,bool>> sendEmail(String email);
  Future<Either<Failure,bool>> recoveryPassword(String email,int code);
  Future<Either<Failure,bool>> editUser(String name,String password);
}



