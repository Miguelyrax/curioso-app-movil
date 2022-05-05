

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:curioso_app/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class GetNewsGeneral extends UseCase<List<News>,NoParams>{
  final NewsRepository repository;

  GetNewsGeneral(this.repository);
  @override
  Future<Either<Failure, List<News>>> execute(NoParams params) {
    return repository.getNewsGeneral();
  }

}