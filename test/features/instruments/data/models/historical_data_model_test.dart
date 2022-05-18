import 'package:curioso_app/features/instruments/data/models/historical_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HistorialDataModel historialDataModel;

  setUp(() {
    historialDataModel = const HistorialDataModel(c: [], h: [], l: [], o: [], s: '123', t: [], v: []);
  });

  test(
    "should be a subclass of HistorialDataModel",
    () async {
      expect(historialDataModel, isA<HistorialDataModel>());
    },
  );
}
