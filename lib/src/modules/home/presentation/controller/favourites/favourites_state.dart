part of 'favourites_cubit.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class FavouritesInitial extends FavouritesState {
  @override
  List<Object> get props => [];
}

class FavouritesLoading extends FavouritesState {
  @override
  List<Object> get props => [];
}

class FavouritesSaved extends FavouritesState {
  final List<String> favouritesIds;

  const FavouritesSaved({required this.favouritesIds});

  @override
  List<Object> get props => [favouritesIds];
}

class FavouritesLoaded extends FavouritesState {
  final List<String> favouritesIds;
  final List<String> images;
  final List<String> names;
  final List<String> prices;

  const FavouritesLoaded({required this.favouritesIds, required this.images, required this.names, required this.prices});

  @override
  List<Object> get props => [favouritesIds, images, names, prices];
}

class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError({required this.message});

  @override
  List<Object> get props => [message];
}
