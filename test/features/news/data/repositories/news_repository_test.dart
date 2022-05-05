
import 'package:curioso_app/features/news/data/datasource/news_datasource.dart';
import 'package:curioso_app/features/news/data/models/news_model.dart';
import 'package:curioso_app/features/news/data/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsDatasoruce extends Mock implements NewsDatasource{}
void main() {
  late MockNewsDatasoruce mockNewsDatasoruce;
  late NewsRepositoryImpl repository;

  setUp(() {
    mockNewsDatasoruce = MockNewsDatasoruce();
    repository = NewsRepositoryImpl(
      mockNewsDatasoruce
    );
  });
  const data= [NewsModel(
    category: '1',
    datetime: 123,
    headline: 'qwe',
    id: 1,
    image: 'qwe',
    related: 'qwe',
    source: 'qwe',
    summary: 'qwe',
    url: 'qwe',
  )];

  group('getNewsGeneral',
  () {
    test(
      "should return data when the call to remote data source is success",
      () async {
        when(mockNewsDatasoruce.getNewsGeneral).thenAnswer((_) async=> data);
        final result=await repository.getNewsGeneral();
        verify(mockNewsDatasoruce.getNewsGeneral);
        expect(result, equals(const Right(data)));
      },
    );
  });
  const symbol ='Appl';
  group('getNewsSymbol',
  () {
    test(
      "should return data when the call to remote data by symbol  is success",
      () async {
        when(()=>mockNewsDatasoruce.getNewsSymbol(symbol)).thenAnswer((_) async=> data);
        final result=await repository.getNewsSymbol(symbol);
        verify(()=>mockNewsDatasoruce.getNewsSymbol(symbol));
        expect(result, equals(const Right(data)));
      },
    );
  });
}
