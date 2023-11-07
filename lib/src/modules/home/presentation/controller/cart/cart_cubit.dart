import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/core/services/shared_preferences.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<String> cachedCartItems = List.empty(growable: true);
  List<String> images = List.empty(growable: true);
  List<String> prices = List.empty(growable: true);

  void saveCartItem(String item, String image, String price) {
    emit(CartLoading());
    List<String> loadedCartItems = List.empty(growable: true);
    List<String> loadedImages = List.empty(growable: true);
    List<String> loadedPrices = List.empty(growable: true);
    SharedPreferencesService.getInstance().then((value) async {
      List<Object?>? loadedData = await value.getValue('cartItems');
      List<Object?>? loadedData2 = await value.getValue('cartImages');
      List<Object?>? loadedData3 = await value.getValue('cartPrices');
      loadedCartItems = loadedData?.cast<String>().toList() ?? cachedCartItems;
      loadedImages = loadedData2?.cast<String>().toList() ?? images;
      loadedPrices = loadedData3?.cast<String>().toList() ?? prices;
      loadedCartItems.contains(item)
          ? debugPrint('$item already exist')
          : loadedCartItems.add(item.toString());
      loadedImages.contains(image)
          ? debugPrint('$image already exist')
          : loadedImages.add(image.toString());
      loadedPrices.contains(price)
          ? debugPrint('$price already exist')
          : loadedPrices.add(price.toString());
      value.saveValue('cartItems', loadedCartItems as List<String>);
      value.saveValue('cartImages', loadedImages as List<String>);
      value.saveValue('cartPrices', loadedPrices as List<String>);
      emit(CartLoaded(
          cartItems: loadedCartItems,
          images: loadedImages,
          prices: loadedPrices));
    });
  }

  void deleteCartItem(String item, String image, String price) {
    List<String> loadedCartItems = List.empty(growable: true);
    List<String> loadedImages = List.empty(growable: true);
    List<String> loadedPrices = List.empty(growable: true);
    emit(CartLoading());
    SharedPreferencesService.getInstance().then((value) async {
      List<Object?>? loadedData = await value.getValue('cartItems');
      List<Object?>? loadedData2 = await value.getValue('cartImages');
      List<Object?>? loadedData3 = await value.getValue('cartPrices');
      loadedCartItems = loadedData?.cast<String>() ?? cachedCartItems;
      loadedImages = loadedData2?.cast<String>() ?? images;
      loadedPrices = loadedData3?.cast<String>() ?? prices;
      loadedCartItems.contains(item)
          ? loadedCartItems.removeWhere(
              (element) {
                return element == item;
              },
            )
          : null;
      loadedImages.contains(image)
          ? loadedImages.removeWhere(
              (element) {
                return element == image;
              },
            )
          : null;
      loadedPrices.contains(price)
          ? loadedPrices.removeWhere(
              (element) {
                return element == price;
              },
            )
          : null;
      value.saveValue('cartItems', loadedCartItems as List<String>);
      value.saveValue('cartImages', loadedImages as List<String>);
      value.saveValue('cartPrices', loadedPrices as List<String>);
      emit(CartLoaded(
          cartItems: loadedCartItems,
          images: loadedImages,
          prices: loadedPrices));
    });
  }

  List<String> loadCartItems() {
    emit(CartLoading());
    SharedPreferencesService.getInstance().then((value) async {
      try {
        List<Object?>? loadedData = await value.getValue('cartItems');
        List<Object?>? loadedData2 = await value.getValue('cartImages');
        List<Object?>? loadedData3 = await value.getValue('cartPrices');
        if (loadedData == null) {
          value.saveValue('cartItems', cachedCartItems);
          value.saveValue('cartImages', images);
          value.saveValue('cartPrices', prices);
        } else {
          // Cast the loaded data to List<String>
          cachedCartItems = loadedData.cast<String>();
          images = loadedData2!.cast<String>();
          prices = loadedData3!.cast<String>();
          debugPrint('loadedCartItems: $cachedCartItems');
          emit(CartLoaded(
              cartItems: cachedCartItems, images: images, prices: prices));
        }
      } catch (e) {
        debugPrint('cartItems error is $e');
      }
    });
    return cachedCartItems;
  }

  void clearCartItems() {
    emit(CartLoading());
    SharedPreferencesService.getInstance().then((value) async {
      value.remove('cartItems');
      emit(CartLoaded(
          cartItems: cachedCartItems, images: images, prices: prices));
    });
  }

  int counter = 1;

  int getCounter() {
    return counter;
  }

  increase() {
    counter++;
    emit(CountChanged(count: counter));
  }

  decrease() {
    if (counter > 1) {
      counter--;
    }
    emit(CountChanged(count: counter));
  }
}
