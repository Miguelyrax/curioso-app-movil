import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';

class PostEditUser extends UseCase<bool,UserParams>{
  final UserRepository repository;

  PostEditUser(this.repository);
  @override
  Future<Either<Failure, bool>> execute(UserParams params) {
    return repository.editUser(params.name!, params.password);
  }

}