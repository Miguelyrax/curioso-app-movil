import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/favourites.dart';
import 'package:curioso_app/features/instruments/domain/usecases/delete_favourite.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_favourites.dart';
import 'package:curioso_app/features/instruments/domain/usecases/post_favourite.dart';
import 'package:equatable/equatable.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetFavourites favoritos;
  final PostFavourite favouriteAdd;
  final DeleteFavourite deleteFavourite;
  FavouritesBloc(this.favoritos, this.favouriteAdd, this.deleteFavourite) : super(FavouritesInitial()) {
    on<FavouritesEvent>((event, emit) {
    });
    on<OnFavouritesLoaded>((event,emit)async{
      emit(FavouritesLoading());
      final result = await favoritos.execute(NoParams());
      result.fold(
        (failure) => emit(const FavouritesError('Error al cargar favoritos')),
        (data) => emit(FavouritesHasData(favoritos: data))
      );
    });
    on<OnFavouriteAdd>((event,emit)async{
      final result = await favouriteAdd.execute(ParamsFavourite(event.id));
      if(state is FavouritesHasData){
        final stateA = state as FavouritesHasData;
        emit(FavouritesLoading());
        result.fold(
          (failure) => emit( FavouritesHasData(favoritos: stateA.favoritos)),
          (data) => emit(stateA.copyWith(favoritos: [data,...stateA.favoritos]))
        );
      }else{
        emit(const FavouritesError('Error al cargar favoritos'));
      }
    });
    on<OnFavouriteDelete>((event,emit)async{
      final result = await deleteFavourite.execute(ParamsFavourite(event.id));
      if(state is FavouritesHasData){
        final stateA = state as FavouritesHasData;
        emit(FavouritesLoading());
        result.fold(
          (failure) =>  emit( FavouritesHasData(favoritos: stateA.favoritos)),
          (data) => emit(stateA.copyWith(favoritos: stateA.favoritos.where((e) => e.instrument.id!=event.id).toList()))
        );
      }else{
        emit(const FavouritesError('Error al eliminar favorito'));
      }
    });
    on<OnFavouritesClear>((event,emit){
      emit(FavouritesInitial());
    });
  }
}
