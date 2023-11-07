import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable{
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  const CategoriesEntity({
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

  const Result({
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
