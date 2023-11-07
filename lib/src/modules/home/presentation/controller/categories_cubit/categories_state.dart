part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  @override
  List<Object> get props => [];
}

class AllCategoriesLoaded extends CategoriesState {
  final CategoriesEntity categoriesEntity;

  const AllCategoriesLoaded({required this.categoriesEntity});

  @override
  List<Object> get props => [categoriesEntity];
}
class CategoriesIdLoaded extends CategoriesState {
  final Result result;

  const CategoriesIdLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({required this.message});

  @override
  List<Object> get props => [message];
}