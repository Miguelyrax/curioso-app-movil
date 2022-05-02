import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';
import 'package:curioso_app/features/instruments/domain/usecases/getInstrument.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_detail.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_historical_data.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/instrument.dart';

part 'instrument_event.dart';
part 'instrument_state.dart';

class InstrumentBloc extends Bloc<InstrumentEvent, InstrumentState> {
  final GetInstrument _getInstrument;
  final GetHistoricalData _getHistoricalData;
  final GetDetail _getDetail;
  InstrumentBloc(this._getInstrument, this._getHistoricalData, this._getDetail) : super(InstrumentInitial()) {
    on<InstrumentEvent>((event, emit) {});
    on<OnLoadingStart>((event, emit) {
      if(state is InstrumentHasData){
        final InstrumentHasData st=state as InstrumentHasData;
        emit(st.copyWith(loading: true));
      }
    });
    on<OnLoadingEnd>((event, emit) {
      if(state is InstrumentHasData){
        final InstrumentHasData st=state as InstrumentHasData;
        emit(st.copyWith(loading: false));
      }
    });

    on<OnInstrumentLoaded>((event,emit)async{
      emit(InstrumentLoading());
      final result= await _getInstrument.execute(NoParams());
      result.fold(
        (failure) => emit(const InstrumentError('Error al cargar')),
        (data) => emit(InstrumentHasData(instruments:data))
      );
    });
    on<OnInstrumentClick>((event,emit)async{
      if(state is InstrumentHasData){
        final InstrumentHasData st=state as InstrumentHasData;
        add(OnLoadingStart());
        final resultDetail= await _getDetail.execute(Params(symbol: event.symbol));
        final resultHistorical= await _getHistoricalData.execute(Params(symbol: event.symbol));
        resultDetail.fold(
          (failure) => print(failure.message),
          (data) => emit(st.copyWith(detail: data))
        );
        // resultHistorical.fold(
        //   (failure) => print(failure.message),
        //   (data) => emit(st.copyWith(historialData: data))
        // );
        add(OnLoadingEnd());
      }
    });
  }
}
