import 'dart:io';

import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:curioso_app/features/quiz/domain/entities/quiz.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/riesgo.dart';

class QuizRepositoryImpl implements QuizRepository{
  final QuizRemoteDataSource remoteDataSource;

  QuizRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, Quiz>> getQuiz() async{
   try {
     final result= await remoteDataSource.getQuiz();
     return Right(result);
   } on ServerException {
     return const Left(ServerFailure('Error'));
   }on SocketException{
     return const Left(ConnectionFailure('Failed to connect to the network'));
   }
  }

  @override
  Future<Either<Failure, Riesgo>> getRiesgo(Map<String,dynamic> data) async{
    try {
     final result= await remoteDataSource.getProfile(data);
     return Right(result);
   } on ServerException {
     return const Left(ServerFailure('Error'));
   }on SocketException{
     return const Left(ConnectionFailure('Failed to connect to the network'));
   }
  }

}