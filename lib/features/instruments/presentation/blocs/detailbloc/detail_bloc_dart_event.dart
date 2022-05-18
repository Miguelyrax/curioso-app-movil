part of 'detail_bloc_dart_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class OnDetailLoaded extends DetailEvent{
  final Instrument instrument;

  const OnDetailLoaded(this.instrument);
}
