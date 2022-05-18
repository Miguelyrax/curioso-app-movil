import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:curioso_app/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_general.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_symbol.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNewsGeneral extends Mock implements GetNewsGeneral{}
class MockGetNewsSymbol extends Mock implements GetNewsSymbol{}


void main() {
  late MockGetNewsSymbol mockGetNewsSymbol;
  late NewsBloc bloc;

  setUp(() {
    mockGetNewsSymbol = MockGetNewsSymbol();
    bloc = NewsBloc(
      getNewsSymbol: mockGetNewsSymbol
    );
  });

  test(
    "initial state should be empty",
    () async {
      expect(bloc.state, equals(NewsInitial()));
    },
  );
  group('GetNews', () {
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
    "should get data from usecase GetNewsSymbol",
    () async {
      when(()=>mockGetNewsSymbol.execute(const Params(symbol: symbol)))
      .thenAnswer((_) async => const Right(data));
      bloc.add(const NewsLoadedSymbol(symbol));
      await untilCalled(()=>mockGetNewsSymbol.execute(const Params(symbol: symbol)));
      verify(()=>mockGetNewsSymbol.execute(const Params(symbol: symbol)));
    },
  );
  blocTest(
    "should emit [loading,has data] when data from getNewsSymbol is gotten successfully",
    build:(){
      when(()=>mockGetNewsSymbol.execute(const Params(symbol: symbol)))
      .thenAnswer((_) async => const Right(data));
      return bloc;
    },
    act:(NewsBloc blocc)=>blocc.add(const NewsLoadedSymbol(symbol)),
    wait: const Duration(milliseconds:500),
    expect: ()=>[
       NewsLoading(),
      const NewsHasData(data)
    ],
    verify: (NewsBloc blocc){
       verify(()=>mockGetNewsSymbol.execute(const Params(symbol: symbol)));
    }
    
  );
    
  });

  
}
