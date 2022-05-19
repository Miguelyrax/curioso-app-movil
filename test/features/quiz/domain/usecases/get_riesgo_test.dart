import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_riesgo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockQuizRepository extends Mock implements QuizRepository{}
void main() {
  late MockQuizRepository mockQuizRepository;
  late GetRiesgo usecase;

  setUp(() {
    mockQuizRepository = MockQuizRepository();
    usecase = GetRiesgo(mockQuizRepository);
  });
  const map ={
    "123":'123',
    "456":'456'
  };
  const data = Riesgo(
    id: '123',
    name: '123',
    description: '123',
    icon: '123'
  );
  test(
    "should return the usecase GetRiesgo from repository",
    () async {
      when(()=>mockQuizRepository.getRiesgo(map))
      .thenAnswer((_) async => const Right(data));
      final result = await usecase.execute(const ParamsRiesgo(data: map));
      verify(()=>mockQuizRepository.getRiesgo(map));
      expect(result, equals(const Right(data)));
    },
  );
}
