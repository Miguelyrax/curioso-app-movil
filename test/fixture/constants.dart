import 'package:curioso_app/features/instruments/data/models/favourites_model.dart';
import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:curioso_app/features/instruments/data/models/stock_exchange_model.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/stock_exchange.dart';

final data=[const Favourites(
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
const dataModel= FavouritesModel(
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
    
  );