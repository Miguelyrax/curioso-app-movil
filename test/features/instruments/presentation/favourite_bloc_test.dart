import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/stock_exchange.dart';
import 'package:curioso_app/features/instruments/domain/usecases/delete_favourite.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_favourites.dart';
import 'package:curioso_app/features/instruments/domain/usecases/post_favourite.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/favourites/favourites_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockGetFavourites extends Mock implements GetFavourites{}
class MockPostFavourites extends Mock implements PostFavourite{}
class MockDeleteFavourite extends Mock implements DeleteFavourite{}
void main() {
  late MockGetFavourites mockGetFavourites;
  late MockPostFavourites mockPostFavourites;
  late MockDeleteFavourite mockDeleteFavourite;
  late FavouritesBloc bloc;

  setUp(() {
    mockGetFavourites = MockGetFavourites();
    mockPostFavourites = MockPostFavourites();
    mockDeleteFavourite = MockDeleteFavourite();
    bloc = FavouritesBloc(mockGetFavourites,mockPostFavourites,mockDeleteFavourite);
  });
  test(
    "initial state should be empty",
    () async {
      expect(bloc.state, isA<FavouritesInitial>());
    },
  );
  const data = [Favourites(
    id: '123',
    instrument: Instrument(
      id: '123',
      name: '123',
      symbol: '123',
      hasIntraday: false,
      hasEod: false,
      country: '123',
      stockExchange: StockExchange(
        acronym: '123',
        city: '123',
        country: '123',
        countryCode: '123',
        mic: '123',
        name: '123',
        website: '123',
        
      )
    )
    
  )];
  const favorito=Favourites(
    id: '123',
    instrument: Instrument(
      id: '123',
      name: '123',
      symbol: '123',
      hasIntraday: false,
      hasEod: false,
      country: '123',
      stockExchange: StockExchange(
        acronym: '123',
        city: '123',
        country: '123',
        countryCode: '123',
        mic: '123',
        name: '123',
        website: '123',
        
      )
    )    
  );

  group('get favourites', () {
    const id='1';
    const params = ParamsFavourite(id);
    test(
      "should get data from usecase",
      () async {
        when(()=>mockGetFavourites.execute(NoParams()))
        .thenAnswer((invocation) async => const Right(data));
        bloc.add(OnFavouritesLoaded());
        await untilCalled(()=>mockGetFavourites.execute(NoParams()));
        verify(()=>mockGetFavourites.execute(NoParams()));
      },
    );
    test(
      "should get data from PostFavourites ",
      () async {
        when(()=>mockPostFavourites.execute(params))
        .thenAnswer((invocation) async => const Right(favorito));
        bloc.add(const OnFavouriteAdd(id));
        await untilCalled(()=>mockPostFavourites.execute(params));
        verify(()=>mockPostFavourites.execute(params));
      },
    );
    test(
      "should get data from DeleteFavourite ",
      () async {
        when(()=>mockDeleteFavourite.execute(params))
        .thenAnswer((invocation) async => const Right(true));
        bloc.add(const OnFavouriteDelete(id));
        await untilCalled(()=>mockDeleteFavourite.execute(params));
        verify(()=>mockDeleteFavourite.execute(params));
      },
    );
    blocTest(
    'emits [FavouriteLoading,FavouriteHasData] when OnFavouritesLoaded() is called.',
    build: () {
      when(()=>mockGetFavourites.execute(NoParams()))
      .thenAnswer((_) async => const Right(data));
      return bloc;
    },
    act: (FavouritesBloc bloc) => bloc.add(OnFavouritesLoaded()),
    expect: () => [
      FavouritesLoading(),
      const FavouritesHasData(favoritos: data)
    ],
    verify: (_) async {
    verify(() => mockGetFavourites.execute(NoParams()));
    },
    );
  });
}
