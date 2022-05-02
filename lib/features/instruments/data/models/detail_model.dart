
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';

class DetailModel extends Detail{
    const DetailModel({
        required String country,
        required String currency,
        required String exchange,
        required String finnhubIndustry,
        required DateTime ipo,
        required String logo,
        required double marketCapitalization,
        required String name,
        required String phone,
        required double shareOutstanding,
        required String ticker,
        required String weburl,
    }) : super(
          country:country,
          currency:currency,
          exchange:exchange,
          finnhubIndustry:finnhubIndustry,
          ipo:ipo,
          logo:logo,
          marketCapitalization:marketCapitalization,
          name:name,
          phone:phone,
          shareOutstanding:shareOutstanding,
          ticker:ticker,
          weburl:weburl,
    );


    factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        country: json["country"],
        currency: json["currency"],
        exchange: json["exchange"],
        finnhubIndustry: json["finnhubIndustry"],
        ipo: DateTime.parse(json["ipo"]),
        logo: json["logo"],
        marketCapitalization: json["marketCapitalization"].toDouble(),
        name: json["name"],
        phone: json["phone"],
        shareOutstanding: json["shareOutstanding"].toDouble(),
        ticker: json["ticker"],
        weburl: json["weburl"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "currency": currency,
        "exchange": exchange,
        "finnhubIndustry": finnhubIndustry,
        "ipo": "${ipo.year.toString().padLeft(4, '0')}-${ipo.month.toString().padLeft(2, '0')}-${ipo.day.toString().padLeft(2, '0')}",
        "logo": logo,
        "marketCapitalization": marketCapitalization,
        "name": name,
        "phone": phone,
        "shareOutstanding": shareOutstanding,
        "ticker": ticker,
        "weburl": weburl,
    };
}
