import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetRiesgo implements UseCase<Riesgo,Params>{
  final QuizRepository quizRepository;

  GetRiesgo(this.quizRepository);
  @override
  Future<Either<Failure,Riesgo>> execute(Params params){
    return quizRepository.getRiesgo(params.data);
  }
}

class Params extends Equatable{
  final Map<String,dynamic> data;

  const Params({required this.data});

  @override
  List<Object?> get props => [data];
}