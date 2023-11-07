import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/config/datasource/web_services/web_services.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/home/data/models/categories_model.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/categories_entity.dart';

abstract class CategoriesWebServices {
  Future<CategoriesEntity> getCategories({
    required String token,
  });

  Future<Result> getCategoriesById({
    required String token,
    required int id,
  });
}

class CategoriesWebServicesImpl implements CategoriesWebServices {
  final WebServices webServices;

  CategoriesWebServicesImpl({required this.webServices});

  @override
  Future<CategoriesEntity> getCategories({
    required String token,
  }) async {
    final response = await webServices.dio.get(ApiUrls.getCategories,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
    );
    if (response.statusCode == 200) {
      try {
        final responseData = response.data;
        debugPrint(
            'API request success with status code ${response.statusCode}');
        final results = CategoriesModel.fromJson(responseData);
        return results;
      } catch (e, s) {
        debugPrint('e is $e \ns is $s');
        return Future.error(e);
      }
    } else {
      debugPrint('API request failed with status code ${response.statusCode}');
      return Future.error(
        'API request failed with status code ${response.statusCode}',
      );
    }
  }

  @override
  Future<Result> getCategoriesById({
    required String token,
    required int id,
  }) async {
    final response = await webServices.dio.get(ApiUrls.getCategoriesById(id),
        options: Options(headers: {
          'Authorization': 'JWT $token',
        }));
    if (response.statusCode == 200) {
      try {
        final responseData = response.data;
        debugPrint(
            'API request success with status code ${response.statusCode}');
        final results = ResultModel.fromJson(responseData);
        return results;
      } catch (e, s) {
        debugPrint('e is $e \ns is $s');
        return Future.error(e);
      }
    } else {
      debugPrint('API request failed with status code ${response.statusCode}');
      return Future.error(
        'API request failed with status code ${response.statusCode}',
      );
    }
  }
}
