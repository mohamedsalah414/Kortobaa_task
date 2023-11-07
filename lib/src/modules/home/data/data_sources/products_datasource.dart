import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/config/datasource/web_services/web_services.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/home/data/models/prodcuts_model.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';

abstract class ProductsWebServices {
  Future<ProductsEntity> getProducts({
    required String token,
  });
  Future<ProductsEntity> getProductsByCategoryId({
    required String token,
  required int catId,
  });

  Future<Result> getProductsById({
    required String token,
    required int id,
  });
}

class ProductsWebServicesImpl implements ProductsWebServices {
  final WebServices webServices;

  ProductsWebServicesImpl({required this.webServices});

  @override
  Future<ProductsEntity> getProducts({
    required String token,
  }) async {
    final response = await webServices.dio.get(ApiUrls.getProducts,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    if (response.statusCode == 200) {
      try {
        final responseData = response.data;
        debugPrint(
            'API request success with status code ${response.statusCode}');
        final results = ProductsModel.fromJson(responseData);
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
  }  @override
  Future<ProductsEntity> getProductsByCategoryId({
    required String token,
    required int catId,
  }) async {
    final response = await webServices.dio.get(ApiUrls.getProductsByCategoryId(catId),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    if (response.statusCode == 200) {
      try {
        final responseData = response.data;
        debugPrint(
            'API request success with status code ${response.statusCode}');
        final results = ProductsModel.fromJson(responseData);
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
  Future<Result> getProductsById({
    required String token,
    required int id,
  }) async {
    final response = await webServices.dio.get(ApiUrls.getProductsById(id),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    if (response.statusCode == 200) {
      try {
        final response = await webServices.dio.get(ApiUrls.getProductsById(id),
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));

        if (response.statusCode == 200) {
          final responseData = response.data;
          debugPrint('API request success with status code ${response.statusCode}');

          if (responseData is List) {
            final productList = responseData.map((productJson) => ResultModel.fromJson(productJson)).toList();
            // Convert the list of ResultModels to a single Result object or modify as per your logic
            final result = productList.first;
            return Future.value(result);
          } else {
            throw 'Response data is not in the expected format';
          }
        } else {
          debugPrint('API request failed with status code ${response.statusCode}');
          throw 'API request failed with status code ${response.statusCode}';
        }
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
