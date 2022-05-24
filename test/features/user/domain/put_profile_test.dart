
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/put_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockUserRepository extends Mock implements UserRepository{}
void main() {
  late MockUserRepository mockUserRepository;
  late PutProfile usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = PutProfile(mockUserRepository);
  });


  test(
    "should return the usecase from repository",
    () async {
      when(()=>mockUserRepository.changeProfile('123'))
      .thenAnswer((_) async => const Right(true));
      final result = await usecase.execute(const UserParamsProfile(id: '123'));
      verify(()=>mockUserRepository.changeProfile('123'));
      expect(result, equals(const Right(true)));
    },
  );
}
