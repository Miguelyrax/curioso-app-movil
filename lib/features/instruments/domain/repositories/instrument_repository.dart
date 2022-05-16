

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:dartz/dartz.dart';

abstract class InstrumentRepository{
  Future<Either<Failure,List<Instrument>>> getInstruments();
  Future<Either<Failure,HistorialData>> getHistoricalData(String symbol);
  Future<Either<Failure,Detail>> getDetailInstrument(String symbol);
  Future<Either<Failure,List<Favourites>>> getFavourites();
}