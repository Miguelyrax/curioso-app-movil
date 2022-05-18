import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInstrumentRepository extends Mock implements InstrumentRepository{}
void main() {
  late MockInstrumentRepository mockInstrumentRepository;
  late GetDetail usecase;

  setUp(() {
    mockInstrumentRepository = MockInstrumentRepository();
    usecase = GetDetail(mockInstrumentRepository);
  });
  const symbol ='APPL';
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
  test(
    "should get the ride side from usecase getDetail",
    () async {
      when(()=>mockInstrumentRepository.getDetailInstrument(symbol))
      .thenAnswer((_) async =>  Right(data));
    },
  );
}
