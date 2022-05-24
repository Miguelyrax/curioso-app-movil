import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PutProfile extends UseCase<bool, UserParamsProfile>{
  final UserRepository repository;

  PutProfile(this.repository);
  @override
  Future<Either<Failure, bool>> execute(UserParamsProfile params) {
    return repository.changeProfile(params.id);
  }

}

class UserParamsProfile extends Equatable{
  final String id;

  const UserParamsProfile(
    {
    required this.id
    }
  );
  
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}