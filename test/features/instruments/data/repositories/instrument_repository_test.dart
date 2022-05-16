import 'package:curioso_app/features/instruments/data/datasource/instrument_remote_data_source.dart';
import 'package:curioso_app/features/instruments/data/models/favourites_model.dart';
import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:curioso_app/features/instruments/data/models/stock_exchange_model.dart';
import 'package:curioso_app/features/instruments/data/repositories/instrument_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockDataSource extends Mock implements InstrumentRemoteDataSource{}
void main() {
  late MockDataSource mockDataSource;
  late InstrumentRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockDataSource();
    repository = InstrumentRepositoryImpl(mockDataSource);
  });
  const dataModel= [FavouritesModel(
    id: '123',
    instrument: InstrumentModel(
      id: '123',
      name: '123',
      symbol: '123',
      hasIntraday: false,
      hasEod: false,
      country: '123',
      stockExchange: StockExchangeModel(
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

  group('favourites', () {
    test(
      "should return data when the call to remote data source is success",
      () async {
        when(()=>mockDataSource.getFavourites())
    .thenAnswer((_) async => dataModel);
    final result = await repository.getFavourites();
    verify(mockDataSource.getFavourites);
    expect(result, equals(const Right(dataModel)));
        
      },
    );
    
  });
}
