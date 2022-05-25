import 'dart:io';
import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/user/data/datasource/user_data_source.dart';
import 'package:curioso_app/features/user/data/models/user_model.dart';
import 'package:curioso_app/features/user/data/repository/user_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockUserDataSource extends Mock implements UserDataSource{}
void main() {
  late MockUserDataSource mockUserDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockUserDataSource = MockUserDataSource();
    repository = UserRepositoryImpl(mockUserDataSource);
  });

  const data = UserModel(
    name: 'miguel',
    email: 'miguel@albanez.com',
    status: true,
    token: '123'
  );

  test(
    "should return data when the call to remote data source is success",
    () async {
      when(()=>mockUserDataSource.login('miguel@albanez.com','123')).thenAnswer((_) async => data);
      final result = await repository.login('miguel@albanez.com','123');
      verify(()=>mockUserDataSource.login('miguel@albanez.com','123'));
      expect(result, equals(const Right(data)));
    },
  );
  test(
    "should return data when the call to remote data source of register is success",
    () async {
      when(()=>mockUserDataSource.register('miguel@albanez.com','123','123')).thenAnswer((_) async => data);
      final result = await repository.register('miguel@albanez.com','123','123');
      verify(()=>mockUserDataSource.register('miguel@albanez.com','123','123'));
      expect(result, equals(const Right(data)));
    },
  );
  test(
    "should return data when the call to remote data source of renew is success",
    () async {
      when(()=>mockUserDataSource.renew()).thenAnswer((_) async => data);
      final result = await repository.renew();
      verify(()=>mockUserDataSource.renew());
      expect(result, equals(const Right(data)));
    },
  );
  

  group('profie', () {
    test(
      "should return data when the call to datasource is sucess",
      () async {
        when(()=>mockUserDataSource.changeProfile('123'))
        .thenAnswer((_) async => true);
        final result = await repository.changeProfile('123');
        verify(()=>mockUserDataSource.changeProfile('123'));
        expect(result, equals(const Right(true)));
      },
    );
    test(
      "should return Server Failure when the remote datasource is unsuccessful",
      () async {
        when(()=>mockUserDataSource.changeProfile('123'))
        .thenThrow(ServerException());
        final result = await repository.changeProfile('123');
        expect(result, const Left(ServerFailure('Error del servidor'))) ;
      },
    );
    test(
      "should return connection failure when the device has no data",
      () async {
        when(()=>mockUserDataSource.changeProfile('123'))
        .thenThrow(const SocketException(''));
        final result = await repository.changeProfile('123');
        expect(result, const Left(ConnectionFailure('Error de conexión'))) ;
      },
    );
  });
  group('recovery password', () {
    const email ='123';
    const code =123;
    test(
      "should return data when the call of datasource is sucess",
      () async {
        when(()=>mockUserDataSource.recoveryPassword(email, code))
        .thenAnswer((_) async => true);
        final result = await repository.recoveryPassword(email, code);
        verify(()=>mockUserDataSource.recoveryPassword(email, code));
        expect(result, const Right(true));
      },
    );
    test(
      "should return Server Failure when the call to remote datasource is unsuccessful",
      () async {
        when(()=>mockUserDataSource.recoveryPassword(email, code))
        .thenThrow(ServerException());
        final result = await repository.recoveryPassword(email, code);
        expect(result, const Left( ServerFailure('Error del servidor')));
      },
    );
    test(
      "should return connection failure when the device has no internet",
      () async {
        when(()=>mockUserDataSource.recoveryPassword(email, code))
        .thenThrow(const SocketException(''));
        final result = await repository.recoveryPassword(email, code);
        expect(result, const Left( ConnectionFailure('Error de conexión')));
      },
    );
  });
  group('send email', () {
    const email ='123';
    test(
      "should return data when the call of datasource is sucess",
      () async {
        when(()=>mockUserDataSource.sendEmail(email))
        .thenAnswer((_) async => true);
        final result = await repository.sendEmail(email);
        verify(()=>mockUserDataSource.sendEmail(email));
        expect(result, const Right(true));
      },
    );
    test(
      "should return Server Failure when the call to remote datasource is unsuccessful",
      () async {
        when(()=>mockUserDataSource.sendEmail(email))
        .thenThrow(ServerException());
        final result = await repository.sendEmail(email);
        expect(result, const Left( ServerFailure('Error del servidor')));
      },
    );
    test(
      "should return connection failure when the device has no internet",
      () async {
        when(()=>mockUserDataSource.sendEmail(email))
        .thenThrow(const SocketException(''));
        final result = await repository.sendEmail(email);
        expect(result, const Left( ConnectionFailure('Error de conexión')));
      },
    );
  });

  group('edit user', () {
    const name = '123';
    const password = '123';
    test(
      "should return data when the call to datasource is success",
      () async {
        when(()=>mockUserDataSource.editUser(name, password))
        .thenAnswer((_) async => true);
        final result = await repository.editUser(name, password);
        verify(()=>mockUserDataSource.editUser(name, password));
        expect(result, const Right(true));
      },
    );
    test(
      "should return ServerFaiulure when the call to datasource is unsuccessful",
      () async {
        when(()=>mockUserDataSource.editUser(name, password))
        .thenThrow(ServerException());
        final result = await repository.editUser(name, password);
        expect(result, const Left(ServerFailure('Error del servidor')));
      },
    );
    test(
      "should return connection failure when the device has no internet",
      () async {
        when(()=>mockUserDataSource.editUser(name, password))
        .thenThrow(const SocketException(''));
        final result = await repository.editUser(name, password);
        expect(result, const Left(ConnectionFailure('Error de conexión')));
      },
    );
  });
}
