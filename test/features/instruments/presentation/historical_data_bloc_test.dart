import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_historical_data.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockGetHistoricalData extends Mock implements GetHistoricalData{}
void main() {
  late MockGetHistoricalData mockGetHistoricalData;
  late HistoricaldataBloc bloc;

  setUp(() {
    mockGetHistoricalData = MockGetHistoricalData();
    bloc = HistoricaldataBloc(mockGetHistoricalData);
  });
  test(
    "initial state should be empty",
    () async {
      expect(bloc.state,isA<HistoricaldataInitial>());
    },
  );
  const symbol = 'APPL';
  const data = HistorialData(c: [], h: [], l: [], o: [], s: '123', t: [], v: []);
  void setUpMockHistoricalData()=>when(()=>mockGetHistoricalData.execute(const Params(symbol: symbol)))
        .thenAnswer((invocation) async => const Right(data));
  group('get historical data', () {
    test(
      "should get the ride side when the usecase is called",
      () async {
        setUpMockHistoricalData();
        bloc.add(const OnHistoricalDataLoaded(symbol));
        await untilCalled(()=>mockGetHistoricalData.execute(const Params(symbol: symbol)));
        verify(()=>mockGetHistoricalData.execute(const Params(symbol: symbol)));
      },
    );
    blocTest(
    'emits [HistoricalLoading, HistoricalHasData] when usecase is called.',
    build: () {
      setUpMockHistoricalData();
      return bloc;
    },
    act: (HistoricaldataBloc blocc) => blocc.add(const OnHistoricalDataLoaded(symbol)),
    expect: () => [
      HistoricaldataILoading(),
      const HistoricaldataHasData(data)
    ],
    verify: (_) async {
    verify(() => mockGetHistoricalData.execute(const Params(symbol: symbol)));
    },
    );
  });
}
