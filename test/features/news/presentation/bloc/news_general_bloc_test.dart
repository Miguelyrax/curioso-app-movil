import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_general.dart';
import 'package:curioso_app/features/news/presentation/bloc/general-news/generalnews_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNewsGeneral extends Mock implements GetNewsGeneral{}
void main() {
  late MockGetNewsGeneral mockGetNewsGeneral;
  late GeneralnewsBloc generalnewsBloc;

  setUp(() {
    mockGetNewsGeneral = MockGetNewsGeneral();
    generalnewsBloc = GeneralnewsBloc(getNewsGeneral: mockGetNewsGeneral);
  });
  test(
    "intial state should be empty",
    () async {
      expect(generalnewsBloc.state, isA<GeneralnewsInitial>());
    },
  );
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

  group('GetNewsGeneral', () {
    
    test(
      "should get data from usecase GetNewsGeneral",
      () async {
        when(()=>mockGetNewsGeneral.execute(NoParams()))
        .thenAnswer((_) async => const Right(data));
        generalnewsBloc.add(GeneralnewsLoading());
        await untilCalled(()=>mockGetNewsGeneral.execute(NoParams()));
        verify(()=>mockGetNewsGeneral.execute(NoParams()));
      },
    );

    blocTest(
      'should emit [loaded, hasdata] when data from GetNewsGeneral is gotten successfully',
      build: (){
        when(()=>mockGetNewsGeneral.execute(NoParams()))
        .thenAnswer((_) async => const Right(data));
        return generalnewsBloc;
      },
      act: (GeneralnewsBloc bloc) => bloc.add(GeneralnewsLoading()),
      expect: () => [
        GeneralnewsLoaded(),
        const GeneralnewsHasData(data)
      ],
      verify: (_) async {
        verify(() => mockGetNewsGeneral.execute(NoParams()));
      },
    );
  });
}
