part of 'instrument_bloc.dart';

abstract class InstrumentState extends Equatable {
  const InstrumentState();
  
  @override
  List<Object?> get props => [];
}

class InstrumentInitial extends InstrumentState {}
class InstrumentLoading extends InstrumentState {}
class InstrumentError extends InstrumentState {
  final String message;

  const InstrumentError(this.message);
}
class InstrumentHasData extends InstrumentState {
  final List<Instrument> instruments;
  final Detail? detail;
  final HistorialData? historialData;
  final bool loading;

  InstrumentHasData copyWith({
      List<Instrument>? instruments,
      Detail? detail,
      HistorialData? historialData,
      bool? loading,
  })=>InstrumentHasData(
      instruments:instruments??this.instruments,
      detail:detail??this.detail,
      historialData:historialData??this.historialData,
      loading:loading??this.loading,
  );

  const InstrumentHasData({
    required this.instruments, 
    this.detail, 
    this.historialData,
    this.loading=false,
  });
  @override
  List<Object?> get props => [instruments,detail,historialData,loading];

}
