import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/stock_exchange.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_detail.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/detailbloc/detail_bloc_dart_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockGetDetail extends Mock implements GetDetail{}
void main() {
  late MockGetDetail mockGetDetail;
  late DetailBloc bloc;

  setUp(() {
    mockGetDetail = MockGetDetail();
    bloc = DetailBloc(mockGetDetail);
  });
  
  final data = Detail(
    country: '123',
    currency: '123',
    exchange: '123',
    finnhubIndustry: '123',
    ipo: DateTime.now(),
    logo: '123',
    marketCapitalization: 2.0,
    name: '123',
    phone: '123',
    shareOutstanding: 2.0,
    ticker: '123',
    weburl: '123'
  );
  
  const instrument=Instrument(
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
    );
  test(
    "initial state should be empty",
    () async {
      expect(bloc.state, isA<DetailInitial>());
      
    },
  );

  group('detail', () {
    final params=Params(symbol: instrument.symbol);
    test(
      "should get the ride side when the usecase is called",
      () async {
        when(()=>mockGetDetail.execute(params))
      .thenAnswer((_) async => Right(data));
      bloc.add(const OnDetailLoaded(instrument));
      await untilCalled(()=>mockGetDetail.execute(params));
      verify(()=>mockGetDetail.execute(params));
      },
    );

    blocTest(
    'emits [DetailLoading,DetailHasdata] when OnDetailLoaded is called.',
    build: () {
      when(()=>mockGetDetail.execute(params))
      .thenAnswer((_) async => Right(data));
      return bloc;
    },
    act: (DetailBloc bloc) => bloc.add(const OnDetailLoaded(instrument)),
    expect: () => [
      DetailLoading(),
      DetailHasData(data, instrument.id)
    ],
    verify: (_) async {
    verify(() => mockGetDetail.execute(params));
    },
    );
  });
}
