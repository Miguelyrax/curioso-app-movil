

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:dartz/dartz.dart';

abstract class InstrumentRepository{
  Future<Either<Failure,List<Instrument>>> getInstruments();
}