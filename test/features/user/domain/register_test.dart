import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:curioso_app/features/user/domain/usecases/register.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockUserRepository extends Mock implements UserRepository{}
void main() {
  late MockUserRepository mockUserRepository;
  late Register usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = Register(mockUserRepository);
  });
  const data = User(
      name: 'miguel',
      email: 'miguel@albanez.com',
      status: true,
      token: '123'
  );
  test(
    "should get the right side of register ",
    () async {
      when(()=>mockUserRepository.register('miguel@albanez.com', '123456', 'miguel')).thenAnswer((_) async => const Right(data));
      final result = await usecase.execute(UserParams(email: 'miguel@albanez.com', password: '123456',name: 'miguel')); 
      expect(result, equals(const Right(data)));
    },
  );
}
