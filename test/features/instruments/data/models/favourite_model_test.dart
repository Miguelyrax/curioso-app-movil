import 'package:curioso_app/features/instruments/data/models/favourites_model.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/constants.dart';

void main() {
  late FavouritesModel favouritesModel;

  setUp(() {
    favouritesModel = dataModel;
  });

  test(
    "should be a subclass of Favourites",
    () async {
      expect(favouritesModel, isA<Favourites>());
    },
  );
}
