part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
  
  @override
  List<Object> get props => [];
}

class FavouritesInitial extends FavouritesState {}
class FavouritesLoading extends FavouritesState {}
class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError(this.message);
}
class FavouritesHasData extends FavouritesState {
  final List<Favourites> favoritos;

  FavouritesHasData copyWith({
    List<Favourites>? favoritos
  })=>FavouritesHasData(
    favoritos:favoritos??this.favoritos
  );

  const FavouritesHasData({required this.favoritos});
  @override
  List<Object> get props => [favoritos];
}
