import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/instrument.dart';

part 'detail_bloc_dart_event.dart';
part 'detail_bloc_dart_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetail _getDetail;
  DetailBloc(this._getDetail) : super(DetailInitial()) {
    on<DetailEvent>((event, emit) {
    });
    on<OnDetailLoaded>((event,emit)async{
      emit(DetailLoading());
      final result=await _getDetail.execute(Params(symbol: event.instrument.symbol));
      result.fold(
        (failure) => emit(const DetailError(message: 'Error al cargar detalle')),
        (data) => emit(DetailHasData(data,event.instrument.id))
      );
    });
  }
}
