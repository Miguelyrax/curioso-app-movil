import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetRiesgo implements UseCase<Riesgo,ParamsRiesgo>{
  final QuizRepository quizRepository;

  GetRiesgo(this.quizRepository);
  @override
  Future<Either<Failure,Riesgo>> execute(ParamsRiesgo params){
    return quizRepository.getRiesgo(params.data);
  }
}

class ParamsRiesgo extends Equatable{
  final Map<String,dynamic> data;

  const ParamsRiesgo({required this.data});

  @override
  List<Object?> get props => [data];
}