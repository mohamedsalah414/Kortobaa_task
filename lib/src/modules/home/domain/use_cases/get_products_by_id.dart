import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/usecase/usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/products_repository.dart';



class GetProductsByIdUseCase
    implements UseCase<Result, ProductsByIdParameters> {
  final ProductsRepository productsRepository;

  GetProductsByIdUseCase({required this.productsRepository});

  @override
  Future<Either<Failure, Result>> call(
      ProductsByIdParameters productsByIdParameters) async {
    try {
      var result = await productsRepository.getProductsById(
        token: productsByIdParameters.token,
        id: productsByIdParameters.id,
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

class ProductsByIdParameters {
  final String token;
  final int id;

  ProductsByIdParameters({
    required this.token,
    required this.id,
  });
}
