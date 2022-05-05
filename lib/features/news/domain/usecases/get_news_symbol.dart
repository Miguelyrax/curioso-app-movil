

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:curioso_app/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class GetNewsSymbol extends UseCase<List<News>,Params>{
  final NewsRepository repository;

  GetNewsSymbol(this.repository);
  @override
  Future<Either<Failure, List<News>>> execute(Params params) async{
    return repository.getNewsSymbol(params.symbol);
  }
  
}


