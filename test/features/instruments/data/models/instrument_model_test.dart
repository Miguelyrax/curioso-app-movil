import 'dart:convert';

import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:curioso_app/features/instruments/data/models/stock_exchange_model.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  late InstrumentModel model;

  setUp(() {
    model = const InstrumentModel(
      id: '62814bb95fd560329705c149',
      name: 'Microsoft Corporation',
      symbol: 'MSFT',
      hasIntraday: false,
      hasEod: true,
      country: null,
      stockExchange: StockExchangeModel(
        acronym: 'NASDAQ',
        city: 'New York',
        country: 'USA',
        countryCode: 'US',
        mic: 'XNAS',
        name: 'NASDAQ Stock Exchange',
        website: 'www.nasdaq.com',
        
      )
    );
  });

  test(
    "should be a subclass of Instrument entity",
    () async {
      expect(model, isA<Instrument>());
    },
  );
  group('From json', (){
    test(
      "should return a valid model when the method fromjson is called",
      () async {
      final List<dynamic> data =json.decode(fixture('instruments.json')) ;
        Map<String,dynamic> map = data[0];
        final result = InstrumentModel.fromJson(map);

      expect(result, equals(model));
      },
    );
  });
}
