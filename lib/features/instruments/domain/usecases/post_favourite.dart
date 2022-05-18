

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/favourites.dart';

class PostFavourite extends UseCase<Favourites,ParamsFavourite>{
  final InstrumentRepository repository;

  PostFavourite(this.repository);
  @override
  Future<Either<Failure, Favourites>> execute(ParamsFavourite params) {
    return repository.postFavourite(params.id);
  }
  
}

class ParamsFavourite extends Equatable{
  final String id;

  const ParamsFavourite(this.id);
  @override
  List<Object?> get props => [
    id
  ];

}