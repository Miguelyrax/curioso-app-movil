import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quiz.dart';

class GetQuiz implements UseCase<Quiz,NoParams>{
  final QuizRepository quizRepository;

  GetQuiz(this.quizRepository);
  @override
  Future<Either<Failure,Quiz>> execute(NoParams params){
    return quizRepository.getQuiz();
  }
}