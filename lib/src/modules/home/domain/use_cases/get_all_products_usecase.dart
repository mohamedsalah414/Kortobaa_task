import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/usecase/usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/products_repository.dart';


class GetAllProductsUseCase
    implements UseCase<ProductsEntity, ProductsParameters> {
  final ProductsRepository productsRepository;

  GetAllProductsUseCase({required this.productsRepository});

  @override
  Future<Either<Failure, ProductsEntity>> call(
      ProductsParameters productsParameters) async {
    try {
      var result = await productsRepository.getProducts(
        token: productsParameters.token,
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

class ProductsParameters {
  final String token;

  ProductsParameters({
    required this.token,
  });
}
