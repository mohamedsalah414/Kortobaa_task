import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/usecase/usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/categories_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/categories_repository.dart';

class GetCategoriesByIdUseCase
    implements UseCase<Result, CategoriesByIdParameters> {
  final CategoriesRepository categoriesRepository;

  GetCategoriesByIdUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, Result>> call(
      CategoriesByIdParameters categoriesByIdParameters) async {
    try {
      var result = await categoriesRepository.getCategoriesById(
        token: categoriesByIdParameters.token,
        id: categoriesByIdParameters.id,
      );

      return result.fold(
            (failure) => Left(failure),
            (success) => Right(success),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class CategoriesByIdParameters {
  final String token;
  final int id;

  CategoriesByIdParameters({
    required this.token,
    required this.id,
  });
}
