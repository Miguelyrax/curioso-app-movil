

import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:curioso_app/features/news/domain/repositories/news_repository.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_symbol.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNewsRepository extends Mock implements NewsRepository{}


void main() {
  late MockNewsRepository mockNewsRepository;
  late GetNewsSymbol usecase;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNewsSymbol(mockNewsRepository);
  });
  const symbol='APPL';
  const data=[
    News(
      category: '1',
      datetime: 123,
      headline: 'qwe',
      id: 1,
      image: 'qwe',
      related: 'qwe',
      source: 'qwe',
      summary: 'qwe',
      url: 'qwe',
    )
  ];
  test(
    "should get a list of news by symbol",
    () async {
      when(()=>mockNewsRepository.getNewsSymbol(symbol))
      .thenAnswer((_) async=> const Right(data));
      final result= await usecase.execute(const Params(symbol: symbol));
      expect(result, equals(const Right(data)));
    },
  );
}
