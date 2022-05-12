

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';

class Register extends UseCase<User,UserParams>{
  final UserRepository repository;

  Register(this.repository);
  @override
  Future<Either<Failure, User>> execute(UserParams params) {
    return repository.register(params.email, params.password, params.name!);
  }

}

