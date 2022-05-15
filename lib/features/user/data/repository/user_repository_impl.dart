import 'dart:io';
import 'package:curioso_app/features/user/data/datasource/user_data_source.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository{
  final UserDataSource datasource;

  UserRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, User>> login(String email, String password) async{
    try {
       final result = await datasource.login(email,password);
       return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password,String name) async{
    try {
       final result = await datasource.register(email,password,name);
       return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }on DatabaseFailure{
      return const Left(DatabaseFailure('Error del servidor'));
    }
  }

  @override
  Future<Either<Failure, User>> renew() async{
    try {
      final result = await datasource.renew();
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }on DatabaseFailure{
      return const Left(DatabaseFailure('Error del servidor'));
    }
  }

}