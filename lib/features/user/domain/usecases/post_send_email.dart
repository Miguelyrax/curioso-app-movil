import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/post_recovery_password.dart';
import 'package:dartz/dartz.dart';

class PostSendEmail extends UseCase<bool,RecoveryParams>{
  final UserRepository repository;

  PostSendEmail(this.repository);
  @override
  Future<Either<Failure, bool>> execute(RecoveryParams params) {
    return repository.sendEmail(params.email);
  }
  
}