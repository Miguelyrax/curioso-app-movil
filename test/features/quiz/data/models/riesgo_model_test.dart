import 'dart:convert';

import 'package:curioso_app/features/quiz/data/models/riesgo_model.dart';
import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  late RiesgoModel model;

  setUp(() {
    model = const RiesgoModel(
    id: '626d88807437b48a4e5bdc50',
    name: 'Balanceado',
    description: '',
    icon: null
  );
  });
  

  group('Riesgo', () {
    test(
    "shoudl be a subclass of Riesgo Entity",
    () async {
      expect(model, isA<Riesgo>());
    },
  );
    test(
      "should return a valid model when the method .fromjson is called",
      () async {
        final RiesgoModel result = RiesgoModel.fromJson(json.decode(fixture('riesgo.json')));
        expect(result, equals(model));
      },
    );
  });
}
