import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/post_recovery_password.dart';
import 'package:curioso_app/features/user/domain/usecases/post_send_email.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository{}
void main() {
  late MockUserRepository mockUserRepository;
  late PostSendEmail usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = PostSendEmail(mockUserRepository);
  });
  const email ='123';
  test(
    "should return the usecase from repository",
    () async {
      when(()=>mockUserRepository.sendEmail(email))
      .thenAnswer((_) async => const Right(true));
      final result = await usecase.execute(const RecoveryParams(email:email));
      verify(()=>mockUserRepository.sendEmail(email));
      expect(result, const Right(true));
    },
  );
}
