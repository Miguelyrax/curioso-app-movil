import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_historical_data.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/historical_data.dart';

part 'historicaldatabloc_event.dart';
part 'historicaldatabloc_state.dart';

class HistoricaldataBloc extends Bloc<HistoricaldataEvent, HistoricaldataState> {
  final GetHistoricalData _getHistoricalData;
  HistoricaldataBloc(this._getHistoricalData) : super(HistoricaldataInitial()) {
    on<HistoricaldataEvent>((event, emit) {
    });
    on<OnHistoricalDataLoaded>((event,emit)async{
      emit(HistoricaldataILoading());
      final result = await _getHistoricalData.execute(Params(symbol: event.symbol));
      result.fold(
        (failure) => emit(const HistoricaldataError(message: 'Error al carga registro de data')),
        (data) => emit(HistoricaldataHasData(data))
      );
    });
  }
}
