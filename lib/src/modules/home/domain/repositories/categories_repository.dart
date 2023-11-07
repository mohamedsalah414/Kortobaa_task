import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/categories_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, CategoriesEntity>> getCategories({
    required String token,
  });

  Future<Either<Failure, Result>> getCategoriesById({
    required String token,
    required int id,
  });
}
