import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_favourites.dart';
import 'package:equatable/equatable.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetFavourites favoritos;
  FavouritesBloc(this.favoritos) : super(FavouritesInitial()) {
    on<FavouritesEvent>((event, emit) {
    });
    on<OnFavouritesLoaded>((event,emit)async{
      emit(FavouritesLoading());
      final result = await favoritos.execute(NoParams());
      result.fold(
        (failure) => emit(const FavouritesError('Error al cargar favoritos')),
        (data) => emit(FavouritesHasData(data))
      );
    });
  }
}
