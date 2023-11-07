import 'dart:convert';

import 'package:krtobaa_task/src/modules/home/domain/entities/categories_entity.dart';

class CategoriesModel extends CategoriesEntity {
  const CategoriesModel({
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

  factory CategoriesModel.fromRawJson(String str) =>
      CategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
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
  }) : super(
          id: id,
          name: name,
          imageLink: imageLink,
        );

  factory ResultModel.fromRawJson(String str) =>
      ResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
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
