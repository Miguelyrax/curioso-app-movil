

import 'package:curioso_app/features/quiz/domain/entities/quiz.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/riesgo.dart';

abstract class QuizRepository{
  Future<Either<Failure,Quiz>> getQuiz();
  Future<Either<Failure,Riesgo>> getRiesgo(Map<String,dynamic> data);
}