

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:dartz/dartz.dart';

class GetInstrument extends UseCase<List<Instrument>,NoParams>{
  final InstrumentRepository repository;

  GetInstrument(this.repository);
  @override
  Future<Either<Failure, List<Instrument>>> execute(NoParams params) {
    return repository.getInstruments();
  }

}