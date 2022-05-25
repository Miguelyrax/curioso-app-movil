import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:curioso_app/features/user/domain/usecases/post_edit_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockUserRepository extends Mock implements UserRepository{}
void main() {
  late MockUserRepository mockUserRepository;
  late PostEditUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = PostEditUser(mockUserRepository);
  });
  const name = '123';
  const password = '123';
  test(
    "should return usecase from the repository",
    () async {
      when(()=>mockUserRepository.editUser(name, password))
      .thenAnswer((_) async => const Right(true));
      final result = await usecase.execute(UserParams(name: name, password: password));
      verify(()=>mockUserRepository.editUser(name, password));
      expect(result, equals(const Right(true)));
    },
  );
}
