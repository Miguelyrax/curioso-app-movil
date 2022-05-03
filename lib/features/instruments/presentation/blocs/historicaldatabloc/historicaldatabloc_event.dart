part of 'historicaldatabloc_bloc.dart';

abstract class HistoricaldataEvent extends Equatable {
  const HistoricaldataEvent();

  @override
  List<Object> get props => [];
}
class OnHistoricalDataLoaded extends HistoricaldataEvent{
  final String symbol;

  const OnHistoricalDataLoaded(this.symbol);
}