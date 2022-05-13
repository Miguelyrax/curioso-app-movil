

import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/quiz/domain/entities/answer.dart' as ans;
import 'package:curioso_app/features/quiz/domain/entities/question.dart';
import 'package:curioso_app/features/quiz/domain/entities/quiz.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_quiz.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockQuizRepository extends Mock implements QuizRepository{}


void main(){
  late MockQuizRepository mockQuizRepository;
  late GetQuiz useCase;

  setUp((){
    mockQuizRepository=MockQuizRepository();
    useCase=GetQuiz(mockQuizRepository);
  });
  const answer=ans.Answer(
    id: '1',
    description:'Limitada, tengo poca experiencia en inversiones'
  );
  const questions=Question(
    id: '16',
    title:'Pregunta D: ¿Cómo clasificaría su experiencia en inversiones (productos y mercados)?',
    answer: [answer]
  );

  const data=Quiz(
    id: '8',
    name: 'Cuestionario Perfil de Riesgo',
    questions: [questions]
  );
  test('should get quiz detail from the repository',
  () async{
    //arrange
    when(mockQuizRepository.getQuiz).thenAnswer((_) async=>const Right(data));
    //act
    final result = await useCase.execute(NoParams());
    //assert
    expect(result, equals(const Right(data)));
  });
}