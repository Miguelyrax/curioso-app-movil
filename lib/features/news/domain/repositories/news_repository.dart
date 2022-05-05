

import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<Failure,List<News>>> getNewsGeneral();
  Future<Either<Failure,List<News>>> getNewsSymbol(String symbol);
}