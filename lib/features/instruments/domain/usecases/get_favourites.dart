
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class GetFavourites extends UseCase<List<Favourites>,NoParams>{
  final InstrumentRepository repository;

  GetFavourites(this.repository);
  @override
  Future<Either<Failure, List<Favourites>>> execute(NoParams params) {
    return repository.getFavourites();
  }
  
}