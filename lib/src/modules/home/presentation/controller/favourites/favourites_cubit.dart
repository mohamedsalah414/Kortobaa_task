import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/core/services/shared_preferences.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());
  List<String> ids = List.empty(growable: true);
  List<String> images = List.empty(growable: true);
  List<String> names = List.empty(growable: true);
  List<String> prices = List.empty(growable: true);

  void saveFavouritesIds(String id, String image, String name, String price) {
    emit(FavouritesLoading());
    List<String> loadedFavoritesIds = List.empty(growable: true);
    SharedPreferencesService.getInstance().then((value) async {
      List<Object?>? loadedData = await value.getValue('favouriteIds');
      List<Object?>? loadedData2 = await value.getValue('favouriteImages');
      List<Object?>? loadedData3 = await value.getValue('favouriteNames');
      List<Object?>? loadedData4 = await value.getValue('favouritePrices');
      loadedFavoritesIds = loadedData?.cast<String>().toList() ?? ids;
      images = loadedData2?.cast<String>().toList() ?? images;
      names = loadedData3?.cast<String>().toList() ?? names;
      prices = loadedData4?.cast<String>().toList() ?? prices;
      loadedFavoritesIds.contains(id)
          ? debugPrint('$id already exist')
          : loadedFavoritesIds.add(id.toString());
      images.contains(image)
          ? debugPrint('$image already exist')
          : images.add(image);
      names.contains(name)
          ? debugPrint('$name already exist')
          : names.add(name);
      prices.contains(price)
          ? debugPrint('$price already exist')
          : prices.add(price);
      /*value.getValue('favouriteLocations')??[];
      for (int i = 0; i < loadedFavoriteLocations.length; i++) {
        if (loadedFavoriteLocations.contains(location)) {
          loadedFavoriteLocations.removeAt(i);
        }
        else {
          loadedFavoriteLocations.add(location);
        }
      }*/
      value.saveValue('favouriteIds', loadedFavoritesIds as List<String>);
      value.saveValue('favouriteImages', images as List<String>);
      value.saveValue('favouriteNames', names as List<String>);
      value.saveValue('favouritePrices', prices as List<String>);
      emit(FavouritesLoaded(
          favouritesIds: loadedFavoritesIds,
          images: images,
          names: names,
          prices: prices));
    });
  }

  void deleteFavouritesIds(String id, String image, String name, String price) {
    List<String> loadedFavoriteIds = List.empty(growable: true);
    List<String> loadedFavoriteImages = List.empty(growable: true);
    List<String> loadedFavoriteNames = List.empty(growable: true);
    List<String> loadedFavoritePrices = List.empty(growable: true);
    emit(FavouritesLoading());
    SharedPreferencesService.getInstance().then((value) async {
      List<Object?>? loadedData = await value.getValue('favouriteIds');
      List<Object?>? loadedData2 = await value.getValue('favouriteImages');
      List<Object?>? loadedData3 = await value.getValue('favouriteNames');
      List<Object?>? loadedData4 = await value.getValue('favouritePrices');
      loadedFavoriteIds = loadedData?.cast<String>() ?? ids;
      loadedFavoriteImages = loadedData2?.cast<String>() ?? images;
      loadedFavoriteNames = loadedData3?.cast<String>() ?? names;
      loadedFavoritePrices = loadedData4?.cast<String>() ?? prices;
      loadedFavoriteIds.contains(id)
          ? loadedFavoriteIds.removeWhere(
              (element) {
                return element == id;
              },
            )
          : null;
      loadedFavoriteImages.contains(image)
          ? loadedFavoriteImages.removeWhere(
              (element) {
                return element == image;
              },
            )
          : null;
      loadedFavoriteNames.contains(name)
          ? loadedFavoriteNames.removeWhere(
              (element) {
                return element == name;
              },
            )
          : null;
      loadedFavoritePrices.contains(price)
          ? loadedFavoritePrices.removeWhere(
              (element) {
                return element == price;
              },
            )
          : null;
      value.saveValue('favouriteIds', loadedFavoriteIds as List<String>);
      value.saveValue('favouriteImages', loadedData2 as List<String>);
      value.saveValue('favouriteNames', loadedData3 as List<String>);
      value.saveValue('favouritePrices', loadedData4 as List<String>);
      emit(FavouritesLoaded(
          favouritesIds: loadedFavoriteIds,
          images: loadedData2 as List<String>,
          names: loadedData3 as List<String>,
          prices: loadedData4 as List<String>));
    });
  }

  List<String> loadFavouritesIds() {
    emit(FavouritesLoading());
    SharedPreferencesService.getInstance().then((value) async {
      try {
        List<Object?>? loadedData = await value.getValue('favouriteIds');
        List<Object?>? loadedData2 = await value.getValue('favouriteImages');
        List<Object?>? loadedData3 = await value.getValue('favouriteNames');
        List<Object?>? loadedData4 = await value.getValue('favouritePrices');
        if (loadedData == null) {
          value.saveValue('favouriteIds', ids);
          value.saveValue('favouriteImages', images);
          value.saveValue('favouriteNames', names);
          value.saveValue('favouritePrices', prices);
        } else {
          // Cast the loaded data to List<String>
          ids = loadedData.cast<String>();
          images = loadedData2?.cast<String>() ?? images;
          names = loadedData3?.cast<String>() ?? names;
          prices = loadedData4?.cast<String>() ?? prices;
          debugPrint('loadedFavoritesIds: $ids');
          emit(FavouritesLoaded(
              favouritesIds: ids,
              images: images,
              names: names,
              prices: prices));
        }
      } catch (e) {
        debugPrint('favouriteIds error is $e');
      }
    });
    return ids;
  }

  void clearFavouriteLocations() {
    emit(FavouritesLoading());
    SharedPreferencesService.getInstance().then((value) {
      value.remove('favouriteIds');
      emit(const FavouritesLoaded(
          favouritesIds: [], images: [], names: [], prices: []));
    });
  }
}
