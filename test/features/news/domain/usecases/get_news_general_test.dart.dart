
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:curioso_app/features/news/domain/repositories/news_repository.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_general.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsRepository extends Mock implements NewsRepository{}
void main() {
  late MockNewsRepository mockNewsRepository;
  late GetNewsGeneral usecase;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNewsGeneral(mockNewsRepository);
  });
  const data= [News(
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

  test(
    "should get list of news",
    () async {
      when(mockNewsRepository.getNewsGeneral).thenAnswer((_) async=> const Right(data));
      final result=await usecase.execute(NoParams());
      expect(result, equals(const Right(data)) );
    },
  );
 
}
