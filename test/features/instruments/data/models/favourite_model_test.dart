import 'package:curioso_app/features/instruments/data/models/favourites_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/constants.dart';

void main() {
  late FavouritesModel favouritesModel;

  setUp(() {
    favouritesModel = dataModel;
  });

  test(
    "should be a subclass of FavouritesModel",
    () async {
      expect(favouritesModel, isA<FavouritesModel>());
    },
  );
}
