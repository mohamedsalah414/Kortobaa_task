import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductsEntity>> getProducts({
    required String token,
  });
  Future<Either<Failure, ProductsEntity>>  getProductsByCategoryId({
    required String token,
    required int catId,
  });

  Future<Either<Failure, Result>> getProductsById({
    required String token,
    required int id,
  });
}
