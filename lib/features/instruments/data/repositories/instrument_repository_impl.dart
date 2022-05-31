
import 'dart:io';

import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/instruments/data/datasource/instrument_remote_data_source.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:dartz/dartz.dart';

class InstrumentRepositoryImpl extends InstrumentRepository{
  final InstrumentRemoteDataSource dataSource;

  InstrumentRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<Instrument>>> getInstruments() async{
    try {
     final result= await dataSource.getInstruments();
     return Right(result);
   } on ServerException {
     return const Left(ServerFailure('Error del servidor'));
   }on SocketException{
     return const Left(ConnectionFailure('Failed to connect to the network'));
   }
  }

  @override
  Future<Either<Failure, Detail>> getDetailInstrument(String symbol) async{
    try {
     final result= await dataSource.getDetailInstrument(symbol);
     return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, HistorialData>> getHistoricalData(String symbol) async{
    try {
     final result= await dataSource.getHistoricalData(symbol);
     return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Favourites>>> getFavourites() async{
    try {
     final result= await dataSource.getFavourites();
     return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Favourites>> postFavourite(String id) async{
    try {
     final result= await dataSource.postFavourites(id);
     return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
  @override
  Future<Either<Failure, bool>> deleteFavourite(String id) async{
    try {
     final result= await dataSource.deleteFavourite(id);
     return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
}