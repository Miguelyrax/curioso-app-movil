import 'dart:io';

import 'package:curioso_app/core/error/exception.dart';
import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/features/instruments/data/datasource/instrument_remote_data_source.dart';
import 'package:curioso_app/features/instruments/data/models/detail_model.dart';
import 'package:curioso_app/features/instruments/data/models/favourites_model.dart';
import 'package:curioso_app/features/instruments/data/models/historical_data_model.dart';
import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:curioso_app/features/instruments/data/models/stock_exchange_model.dart';
import 'package:curioso_app/features/instruments/data/repositories/instrument_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixture/constants.dart';
class MockDataSource extends Mock implements InstrumentRemoteDataSource{}
void main() {
  late MockDataSource mockDataSource;
  late InstrumentRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockDataSource();
    repository = InstrumentRepositoryImpl(mockDataSource);
  });
  const symbol = 'APPL';
  const dataModell= [FavouritesModel(
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

  const id='asd';

  group('favourites', () {
    test(
      "should return data when the call to remote data source is success",
      () async {
        when(()=>mockDataSource.getFavourites())
    .thenAnswer((_) async => dataModell);
    final result = await repository.getFavourites();
    verify(mockDataSource.getFavourites);
    expect(result, equals(const Right(dataModell)));
        
      },
    );
    test(
      "should return server failure when a call to data source is unsuccessful",
      () async {
        when(()=>mockDataSource.getFavourites())
        .thenThrow( ServerException());
        final result = await repository.getFavourites();
        expect(result, equals(const Left(ServerFailure('Error del servidor'))));
      },
    );

    test(
      "should return server failure when the device has no internet",
      () async {
        when(()=>mockDataSource.getFavourites())
        .thenThrow( const SocketException(''));
        final result = await repository.getFavourites();
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
    test(
      "should return data when the call to remote data source is success in postFavourites",
      () async {
        when(()=>mockDataSource.postFavourites(id))
        .thenAnswer((_) async => dataModel);
        final result = await repository.postFavourite(id);
        verify(()=>mockDataSource.postFavourites(id));
        expect(result, equals(const Right(dataModel)));
      },
    );
    test(
      "should return server failure when a call to data is unsucceessful",
      () async {
        when(()=>mockDataSource.postFavourites(id))
        .thenThrow(ServerException());
        final result = await repository.postFavourite(id);
        expect(result, equals(const Left(ServerFailure('Error del servidor'))));
      },
    );
    test(
      "should return connection failure when athe device has not internet",
      () async {
        when(()=>mockDataSource.postFavourites(id))
        .thenThrow(const SocketException(''));
        final result = await repository.postFavourite(id);
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
    
  });

  group('detail', () {
  final data = DetailModel(
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
      "should return data when the call to remote data source is success",
      () async {
        when(()=>mockDataSource.getDetailInstrument(symbol))
        .thenAnswer((_) async => data);
        final result = await repository.getDetailInstrument(symbol);
        verify(()=>mockDataSource.getDetailInstrument(symbol));
        expect(result, equals(Right(data)));
      },
    );
    test(
      "should return server failure when the call to data is unsuccessful",
      () async {
        when(()=>mockDataSource.getDetailInstrument(symbol))
        .thenThrow(ServerException());
        final result = await repository.getDetailInstrument(symbol);
        expect(result, equals(const Left(ServerFailure('Error del servidor'))));
      },
    );
    test(
      "should return connection failure when the device has no internet",
      () async {
        when(()=>mockDataSource.getDetailInstrument(symbol))
        .thenThrow(const SocketException(''));
        final result = await repository.getDetailInstrument(symbol);
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });

  group('Historical data', (){
    const data = HistorialDataModel(c: [], h: [], l: [], o: [], s: '123', t: [], v: []);
    test(
      "should the call of remote data source is success",
      () async {
        when(()=>mockDataSource.getHistoricalData(symbol))
        .thenAnswer((_) async => data);
        final result = await repository.getHistoricalData(symbol);
        verify(()=>mockDataSource.getHistoricalData(symbol));
        expect(result, equals(const Right(data)));
      },
    );
    test(
      "should return ServerFailure when the call to remote data source is unsuccessful",
      () async {
        when(()=>mockDataSource.getHistoricalData(symbol))
        .thenThrow(ServerException());
        final result = await repository.getHistoricalData(symbol);
        expect(result, equals(const Left(ServerFailure('Error del servidor'))));
      },
    );

    test(
      "should return connection failure when the device has no internet",
      () async {
        when(()=>mockDataSource.getHistoricalData(symbol))
        .thenThrow(const SocketException('Failed to connect to the network'));
        final result = await repository.getHistoricalData(symbol);
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });
}
