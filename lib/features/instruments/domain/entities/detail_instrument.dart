

import 'package:equatable/equatable.dart';

class Detail extends Equatable{
    const Detail({
        required this.country,
        required this.currency,
        required this.exchange,
        required this.finnhubIndustry,
        required this.ipo,
        required this.logo,
        required this.marketCapitalization,
        required this.name,
        required this.phone,
        required this.shareOutstanding,
        required this.ticker,
        required this.weburl,
    });

    final String country;
    final String currency;
    final String exchange;
    final String finnhubIndustry;
    final DateTime ipo;
    final String logo;
    final int marketCapitalization;
    final String name;
    final String phone;
    final double shareOutstanding;
    final String ticker;
    final String weburl;

  @override
  List<Object?> get props => [
      country,
      currency,
      exchange,
      finnhubIndustry,
      ipo,
      logo,
      marketCapitalization,
      name,
      phone,
      shareOutstanding,
      ticker,
      weburl,
  ];
}
