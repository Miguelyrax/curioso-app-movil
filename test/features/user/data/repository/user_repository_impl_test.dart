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
}
