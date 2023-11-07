import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/exception.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/home/data/data_sources/products_datasource.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsWebServices apiProvider;

  ProductsRepositoryImpl({required this.apiProvider});

  @override
  Future<Either<Failure, ProductsEntity>> getProducts({
    required String token,
  }) async {
    try {
      final response = await apiProvider.getProducts(
        token: token,
      );
      return Right(response);
    } on NoInternetConnectionException catch (_) {
      return const Left(
          ServerFailure(message: AppStrings.noInternetConnection));
    } on InternalServerErrorException catch (_) {
      return const Left(ServerFailure(message: AppStrings.internalServerError));
    } on FormatException catch (_) {
      return const Left(
          ServerFailure(message: AppStrings.errorOccurredDuringReadingData));
    } catch (exception) {
      return const Left(ServerFailure(message: AppStrings.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, ProductsEntity>> getProductsByCategoryId({
    required String token,
    required int catId,
  }) async {
    try {
      final response = await apiProvider.getProductsByCategoryId(
        token: token,
        catId: catId,
      );
      return Right(response);
    } on NoInternetConnectionException catch (_) {
      return const Left(
          ServerFailure(message: AppStrings.noInternetConnection));
    } on InternalServerErrorException catch (_) {
      return const Left(ServerFailure(message: AppStrings.internalServerError));
    } on FormatException catch (_) {
      return const Left(
          ServerFailure(message: AppStrings.errorOccurredDuringReadingData));
    } catch (exception) {
      return const Left(ServerFailure(message: AppStrings.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, Result>> getProductsById({
    required String token,
    required int id,
  }) async {
    try {
      final response = await apiProvider.getProductsById(
        token: token,
        id: id,
      );
      return Right(response);
    } on NoInternetConnectionException catch (_) {
      return const Left(
          ServerFailure(message: AppStrings.noInternetConnection));
    } on InternalServerErrorException catch (_) {
      return const Left(ServerFailure(message: AppStrings.internalServerError));
    } on FormatException catch (_) {
      return const Left(
          ServerFailure(message: AppStrings.errorOccurredDuringReadingData));
    } catch (exception) {
      return const Left(ServerFailure(message: AppStrings.somethingWentWrong));
    }
  }
}
