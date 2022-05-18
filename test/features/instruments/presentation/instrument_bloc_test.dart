import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/stock_exchange.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_instrument.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/instrumentbloc/instrument_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockGetInstrument extends Mock implements GetInstrument{}
void main() {
  late MockGetInstrument mockGetInstrument;
  late InstrumentBloc bloc;

  setUp(() {
    mockGetInstrument = MockGetInstrument();
    bloc = InstrumentBloc(mockGetInstrument);
  });
  test(
    "initial state should be empty",
    () async {
      expect(bloc.state,isA<InstrumentInitial>());
    },
  );

  group('Get Instrument', () {
    const data =  [Instrument(
      id: '62814bb95fd560329705c149',
      name: 'Microsoft Corporation',
      symbol: 'MSFT',
      hasIntraday: false,
      hasEod: true,
      country: null,
      stockExchange: StockExchange(
        acronym: 'NASDAQ',
        city: 'New York',
        country: 'USA',
        countryCode: 'US',
        mic: 'XNAS',
        name: 'NASDAQ Stock Exchange',
        website: 'www.nasdaq.com',
        
      )
    )];

    void setUpMockHistoricalData()=>when(()=>mockGetInstrument.execute(NoParams()))
        .thenAnswer((_) async => const Right(data));
    test(
      "should return data from usecase",
      () async {
        setUpMockHistoricalData();
        bloc.add(OnInstrumentLoaded());
        untilCalled(()=>mockGetInstrument.execute(NoParams()));
        verifyNever(()=>mockGetInstrument.execute(NoParams()));
      },
    );
    blocTest(
    'emits [InstrumentLoadind, InstrumentHasData] when usecase is called.',
    build: () {
      setUpMockHistoricalData();
      return bloc;
    },
    act: (InstrumentBloc blocc) => blocc.add(OnInstrumentLoaded()),
    expect: () => [
      InstrumentLoading(),
      const InstrumentHasData(instruments: data)
    ],
    verify: (_) async {
    verify(() => mockGetInstrument.execute(NoParams()));
    },
    );
  });
}
