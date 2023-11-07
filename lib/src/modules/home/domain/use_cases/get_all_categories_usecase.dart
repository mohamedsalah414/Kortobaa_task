import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/usecase/usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/categories_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/categories_repository.dart';

class GetAllCategoriesUseCase
    implements UseCase<CategoriesEntity, CategoriesParameters> {
  final CategoriesRepository categoriesRepository;

  GetAllCategoriesUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, CategoriesEntity>> call(
      CategoriesParameters categoriesParameters) async {
    try {
      var result = await categoriesRepository.getCategories(
        token: categoriesParameters.token,
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

class CategoriesParameters {
  final String token;

  CategoriesParameters({
    required this.token,
  });
}
