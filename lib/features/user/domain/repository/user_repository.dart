import 'package:curioso_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class UserRepository{
  Future<Either<Failure,User>> login(String email, String password);
  Future<Either<Failure,User>> register(String email, String password,String name);
}



