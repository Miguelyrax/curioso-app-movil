import 'dart:convert';

import 'package:curioso_app/features/instruments/domain/entities/stock_exchange.dart';

class StockExchangeModel extends StockExchange {
    const StockExchangeModel({
        required String name,
        required String acronym,
        required String mic,
        required String country,
        required String countryCode,
        required String city,
        required String website,
    }) : super(
            name:name,
            acronym:acronym,
            mic:mic,
            country:country,
            countryCode:countryCode,
            city:city,
            website:website,
    );


    factory StockExchangeModel.fromJson(String str) => StockExchangeModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StockExchangeModel.fromMap(Map<String, dynamic> json) => StockExchangeModel(
        name: json["name"],
        acronym: json["acronym"],
        mic: json["mic"],
        country: json["country"],
        countryCode:json["country_code"],
        city:json["city"],
        website:json["website"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "acronym": acronym,
        "mic": mic,
        "country": country,
        "country_code":countryCode,
        "city": city,
        "website": website,
    };
}
