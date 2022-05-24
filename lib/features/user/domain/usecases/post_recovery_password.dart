import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PostRecoveryPassword extends UseCase<bool,RecoveryParams>{
  final UserRepository repository;

  PostRecoveryPassword(this.repository);
  @override
  Future<Either<Failure, bool>> execute(RecoveryParams params) {
    return repository.recoveryPassword(params.email, params.code!);
  }

}

class RecoveryParams extends Equatable{
  final String email;
  final int? code;

  const RecoveryParams({required this.email, this.code});
  
  @override
  List<Object?> get props => [email];
}