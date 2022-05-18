import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/stock_exchange.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_instrument.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInstrumentRepository extends Mock implements InstrumentRepository{}
void main() {
  late MockInstrumentRepository mockInstrumentRepository;
  late GetInstrument usecase;

  setUp(() {
    mockInstrumentRepository = MockInstrumentRepository();
    usecase = GetInstrument(mockInstrumentRepository);
  });

  const data = [Instrument(
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
    )];

  test(
    "should get usecase from repository",
    () async {
      when(()=>mockInstrumentRepository.getInstruments())
      .thenAnswer((_) async => const Right(data));
      final result = await usecase.execute(NoParams());
      verify(()=>mockInstrumentRepository.getInstruments());
      expect(result, equals(const Right(data)));
    },
  );
}
