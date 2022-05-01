import 'package:equatable/equatable.dart';

class StockExchange extends Equatable{
    const StockExchange({
        required this.name,
        required this.acronym,
        required this.mic,
        required this.country,
        required this.countryCode,
        required this.city,
        required this.website,
    });

    final String name;
    final String acronym;
    final String mic;
    final String country;
    final String countryCode;
    final String city;
    final String website;

  @override
  List<Object?> get props => [
    name,
    acronym,
    mic,
    country,
    countryCode,
    city,
    website,
  ];

}
