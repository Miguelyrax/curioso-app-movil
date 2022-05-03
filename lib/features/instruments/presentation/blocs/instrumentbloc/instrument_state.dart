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

  const InstrumentHasData({
    required this.instruments, 
  });
  @override
  List<Object?> get props => [instruments];

}
