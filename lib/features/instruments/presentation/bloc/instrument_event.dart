part of 'instrument_bloc.dart';

abstract class InstrumentEvent extends Equatable {
  const InstrumentEvent();

  @override
  List<Object> get props => [];
}

class OnInstrumentLoaded extends InstrumentEvent{}
class OnLoadingStart extends InstrumentEvent{}
class OnLoadingEnd extends InstrumentEvent{}
class OnInstrumentClick extends InstrumentEvent{
  final String symbol;

  const OnInstrumentClick(this.symbol);
}
