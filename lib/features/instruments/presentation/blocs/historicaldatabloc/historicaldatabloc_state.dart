part of 'historicaldatabloc_bloc.dart';

abstract class HistoricaldataState extends Equatable {
  const HistoricaldataState();
  
  @override
  List<Object> get props => [];
}

class HistoricaldataInitial extends HistoricaldataState {}
class HistoricaldataILoading extends HistoricaldataState {}
class HistoricaldataError extends HistoricaldataState {
  final String message;

  const HistoricaldataError({required this.message});
}
class HistoricaldataHasData extends HistoricaldataState {
  final HistorialData historialData;

  const HistoricaldataHasData(this.historialData);
}
