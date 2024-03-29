import 'dart:io';
import 'package:curioso_app/core/error/exception.dart';
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
    } on ServerException {
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
    } on ServerException {
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
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }on DatabaseFailure{
      return const Left(DatabaseFailure('Error del servidor'));
    }
  }

  @override
  Future<Either<Failure, bool>> changeProfile(String id) async{
    try {
      final result = await datasource.changeProfile(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }on DatabaseFailure{
      return const Left(DatabaseFailure('Error del servidor'));
    }
  }
  
  @override
  Future<Either<Failure, bool>> recoveryPassword(String email, int code) async{
    try {
      final result = await datasource.recoveryPassword(email,code);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }on DatabaseFailure{
      return const Left(DatabaseFailure('Error del servidor'));
    }
  }
  
  @override
  Future<Either<Failure, bool>> sendEmail(String email) async{
    try {
      final result = await datasource.sendEmail(email);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }on DatabaseFailure{
      return const Left(DatabaseFailure('Error del servidor'));
    }
  }
  
  @override
  Future<Either<Failure, bool>> editUser(String name, String password)async{
    try {
      final result = await datasource.editUser(name,password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error del servidor'));
    }on SocketException{
      return const Left(ConnectionFailure('Error de conexión'));
    }on DatabaseFailure{
      return const Left(DatabaseFailure('Error del servidor'));
    }
  }

}