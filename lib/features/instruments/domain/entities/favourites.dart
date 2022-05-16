
import 'package:curioso_app/features/instruments/domain/entities/instrument.dart';
import 'package:equatable/equatable.dart';

class Favourites extends Equatable{
    const Favourites({
        required this.instrument,
        required this.id,
    });
    final Instrument instrument;
    final String id;

  @override
  List<Object?> get props => [
    instrument,
    id
  ];
}