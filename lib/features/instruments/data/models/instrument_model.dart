
import 'package:curioso_app/features/instruments/data/models/stock_exchange_model.dart';
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';

class InstrumentModel extends Instrument{
    const InstrumentModel({
        required String id,
        required String name,
        required String symbol,
        required bool hasIntraday,
        required bool hasEod,
        required dynamic country,
        required StockExchangeModel stockExchange,
    }) : super(
          id:id,
          name:name,
          symbol:symbol,
          hasIntraday:hasIntraday,
          hasEod:hasEod,
          country:country,
          stockExchange:stockExchange,
    );

    factory InstrumentModel.fromJson(Map<String, dynamic> json) => InstrumentModel(
        id: json["id"]??json["_id"],
        name: json["name"],
        symbol: json["symbol"],
        hasIntraday: json["has_intraday"],
        hasEod: json["has_eod"],
        country: json["country"],
        stockExchange: StockExchangeModel.fromMap(json["stock_exchange"]),
    );

}
