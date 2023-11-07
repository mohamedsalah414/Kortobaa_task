import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/exception.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/home/data/data_sources/categories_datasource.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/categories_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesWebServices apiProvider;

  CategoriesRepositoryImpl({required this.apiProvider});

  @override
  Future<Either<Failure, CategoriesEntity>> getCategories({
    required String token,
  }) async {
    try {
      final response = await apiProvider.getCategories(
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
  Future<Either<Failure, Result>> getCategoriesById({
    required String token,
    required int id,
  }) async {
    try {
      final response = await apiProvider.getCategoriesById(
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
