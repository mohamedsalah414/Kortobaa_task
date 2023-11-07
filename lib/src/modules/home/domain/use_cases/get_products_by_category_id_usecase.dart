import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/usecase/usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/products_repository.dart';


class GetProductsByCategoryIdUseCase
    implements UseCase<ProductsEntity, ProductsByCategoryIdParameters> {
  final ProductsRepository productsRepository;

  GetProductsByCategoryIdUseCase({required this.productsRepository});

  @override
  Future<Either<Failure, ProductsEntity>> call(
      ProductsByCategoryIdParameters productsByCategoryIdParameters) async {
    try {
      var result = await productsRepository.getProductsByCategoryId(
        token: productsByCategoryIdParameters.token,
        catId: productsByCategoryIdParameters.catId,
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

class ProductsByCategoryIdParameters {
  final String token;
  final int catId;

  ProductsByCategoryIdParameters({
    required this.token,
    required this.catId,
  });
}
