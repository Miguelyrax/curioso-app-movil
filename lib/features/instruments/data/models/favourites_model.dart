
import 'package:curioso_app/features/instruments/data/models/instrument_model.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';

class FavouritesModel extends Favourites {
    const FavouritesModel({
        required InstrumentModel instrument,
        required String id,
    }) : super(instrument:instrument, id:id);

    factory FavouritesModel.fromJson(Map<String, dynamic> json) => FavouritesModel(
        instrument: InstrumentModel.fromJson(json["favorito"]),
        id: json["id"],
    );
}