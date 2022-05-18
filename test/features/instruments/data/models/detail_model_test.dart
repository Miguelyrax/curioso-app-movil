import 'package:curioso_app/features/instruments/data/models/detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DetailModel model;
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

  setUp(() {
    model = data;
  });

  test(
    "should be a subclass of DetailModel",
    () async {
      expect(model, isA<DetailModel>());
    },
  );
}
