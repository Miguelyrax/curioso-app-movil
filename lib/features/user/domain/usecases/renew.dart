

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class Renew extends UseCase<User,NoParams>{
  final UserRepository repository;

  Renew(this.repository);
  @override
  Future<Either<Failure, User>> execute(NoParams params) {
    return repository.renew();
  }

}