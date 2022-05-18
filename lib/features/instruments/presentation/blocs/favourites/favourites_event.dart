part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class OnFavouritesLoaded extends FavouritesEvent{}
class OnFavouriteAdd extends FavouritesEvent{
  final String id;

  const OnFavouriteAdd(this.id);
}