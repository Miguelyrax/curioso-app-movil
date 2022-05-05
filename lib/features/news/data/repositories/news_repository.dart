

import 'dart:io';

import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/news/data/datasource/news_datasource.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepositoryImpl extends NewsRepository{
  final NewsDatasource datasource;

  NewsRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, List<News>>> getNewsGeneral() async{
    try {
      final result=await datasource.getNewsGeneral();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexion'));
    }
  }

  @override
  Future<Either<Failure, List<News>>> getNewsSymbol(String symbol)async {
    try {
      final result=await datasource.getNewsSymbol(symbol);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexion'));
    }
  }

}