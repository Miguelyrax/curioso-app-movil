
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/renew.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockUserRepository extends Mock implements UserRepository{}
void main() {
  late MockUserRepository mockUserRepository;
  late Renew usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = Renew(mockUserRepository);
  });
  const data = User(
    name: 'miguel',
    email: 'miguel@albanez.com',
    status: true,
    token: '123'
  );
  test(
    'should return right side of renew',
    () async {
      when(()=>mockUserRepository.renew()).thenAnswer((_) async => const Right(data));
      final result = await usecase.execute(NoParams());
      expect(result, equals(const Right(data)));
    },
  );
}
