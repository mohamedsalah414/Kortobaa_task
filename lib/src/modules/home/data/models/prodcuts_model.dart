import 'dart:convert';

import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';

class ProductsModel extends ProductsEntity {
  const ProductsModel({
    int? count,
    dynamic? next,
    dynamic? previous,
    List<Result>? results,
  }) : super(
          count: count,
          next: next,
          previous: previous,
          results: results,
        );

  factory ProductsModel.fromRawJson(String str) =>
      ProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? null
            : List<Result>.from(
                json["results"].map((x) => ResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "rresults": results,
      };
}

class ResultModel extends Result {
  const ResultModel({
    int? id,
    String? name,
    String? imageLink,
    String? price,
    String? description,
    String? rate,
    Category? category,
  }) : super(
          id: id,
          name: name,
          imageLink: imageLink,
          price: price,
          description: description,
          rate: rate,
          category: category,
        );

  factory ResultModel.fromRawJson(String str) =>
      ResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
        price: json["price"],
        description: json["description"],
        rate: json["rate"],
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
        "price": price,
        "description": description,
        "rate": rate,
        "category": category,
      };
}

class CategoryModel extends Category {
  const CategoryModel({
    int? id,
    String? name,
    String? imageLink,
  }) : super(
          id: id,
          name: name,
          imageLink: imageLink,
        );

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
      };
}
