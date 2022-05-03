import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';
import 'package:curioso_app/features/instruments/domain/usecases/getInstrument.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_detail.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_historical_data.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/instrument.dart';

part 'instrument_event.dart';
part 'instrument_state.dart';

class InstrumentBloc extends Bloc<InstrumentEvent, InstrumentState> {
  final GetInstrument _getInstrument;
  InstrumentBloc(this._getInstrument) : super(InstrumentInitial()) {
    on<InstrumentEvent>((event, emit) {});

    on<OnInstrumentLoaded>((event,emit)async{
      emit(InstrumentLoading());
      final result= await _getInstrument.execute(NoParams());
      result.fold(
        (failure) => emit(const InstrumentError('Error al cargar')),
        (data) => emit(InstrumentHasData(instruments:data))
      );
    });
  }
}
