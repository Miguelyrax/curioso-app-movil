import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/post_favourite.dart';
import 'package:dartz/dartz.dart';

class DeleteFavourite extends UseCase<bool,ParamsFavourite>{
  final InstrumentRepository repository;

  DeleteFavourite(this.repository);
  @override
  Future<Either<Failure, bool>> execute(ParamsFavourite params) {
    return repository.deleteFavourite(params.id);
  }

}