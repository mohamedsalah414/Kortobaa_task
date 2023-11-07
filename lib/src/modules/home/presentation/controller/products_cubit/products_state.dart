part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  List<Object> get props => [];
}
class MostPopularProductsLoading extends ProductsState {
  @override
  List<Object> get props => [];
}
class MostRecentProductsLoading extends ProductsState {
  @override
  List<Object> get props => [];
}

class AllProductsLoaded extends ProductsState {
  final ProductsEntity productsEntity;

  const AllProductsLoaded({required this.productsEntity});

  @override
  List<Object> get props => [productsEntity];
}

class ProductsByCategoryId extends ProductsState {
  final ProductsEntity productsEntity;

  const ProductsByCategoryId({required this.productsEntity});

  @override
  List<Object> get props => [productsEntity];
}

class MostPopularProducts extends ProductsState {
  final ProductsEntity productsEntity;

  const MostPopularProducts({required this.productsEntity});

  @override
  List<Object> get props => [productsEntity];
}

class MostRecentProducts extends ProductsState {
  final ProductsEntity productsEntity;

  const MostRecentProducts({required this.productsEntity});

  @override
  List<Object> get props => [productsEntity];
}

class ProductsIdLoaded extends ProductsState {
  final Result result;

  const ProductsIdLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
class MostPopularProductsError extends ProductsState {
  final String message;

  const MostPopularProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
class MostRecentProductsError extends ProductsState {
  final String message;

  const MostRecentProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
