part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<String> cartItems;
  final List<String> images;
  final List<String> prices;

  const CartLoaded({required this.cartItems, required this.images, required this.prices});

  @override
  List<Object> get props => [cartItems, images, prices];
}

class CartSaved extends CartState {
  final List<String> cartItems;

  const CartSaved({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}
class CountChanged extends CartState {
  final int count;

  const CountChanged({required this.count});

  @override
  List<Object> get props => [count];
}
class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}
