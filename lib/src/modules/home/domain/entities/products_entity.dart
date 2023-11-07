import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable{
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  const ProductsEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  @override
  List<Object?> get props => [
    count,
    next,
    previous,
    results,
  ];
}

class Result extends Equatable{
  final int? id;
  final String? name;
  final String? imageLink;
  final String? price;
  final String? description;
  final String? rate;
  final Category? category;

  const Result({
    this.id,
    this.name,
    this.imageLink,
    this.price,
    this.description,
    this.rate,
    this.category,
  });
  @override
  List<Object?> get props => [
    id,
    name,
    imageLink,
    price,
    description,
    rate,
    category,
  ];
}

class Category extends Equatable{
  final int? id;
  final String? name;
  final String? imageLink;

  const Category({
    this.id,
    this.name,
    this.imageLink,
  });
  @override
  List<Object?> get props => [
    id,
    name,
    imageLink,];
}
