

import 'package:curioso_app/features/instruments/domain/entities/stock_exchange.dart';
import 'package:equatable/equatable.dart';

class Instrument extends Equatable{
    const Instrument({
        required this.id,
        required this.name,
        required this.symbol,
        required this.hasIntraday,
        required this.hasEod,
        required this.country,
        required this.stockExchange,
    });
    final String id;
    final String name;
    final String symbol;
    final bool hasIntraday;
    final bool hasEod;
    final dynamic country;
    final StockExchange stockExchange;

  @override
  List<Object?> get props => [
  id,
  name,
  symbol,
  hasIntraday,
  hasEod,
  country,
  stockExchange,
  ];

}

