import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_historical_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockInstrumentRepository extends Mock implements InstrumentRepository{}
void main() {
  late MockInstrumentRepository mockInstrumentRepository;
  late GetHistoricalData usecase;

  setUp(() {
    mockInstrumentRepository = MockInstrumentRepository();
    usecase = GetHistoricalData(mockInstrumentRepository);
  });
  const symbol = 'APPL';
  const data = HistorialData(c: [], h: [], l: [], o: [], s: '123', t: [], v: []);
  test(
    "should return the ride side from usecase",
    () async {
      when(()=>mockInstrumentRepository.getHistoricalData(symbol))
      .thenAnswer((_) async => const Right(data));
      final result = await usecase.execute(const Params(symbol: symbol));
      verify(()=>mockInstrumentRepository.getHistoricalData(symbol));
      expect(result, equals(const Right(data)));
    },
  );
}
