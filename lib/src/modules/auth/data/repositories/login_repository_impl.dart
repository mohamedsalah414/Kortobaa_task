import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/exception.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/auth/data/data_sources/login_datasource.dart';
import 'package:krtobaa_task/src/modules/auth/data/data_sources/register_datasource.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/login_entity.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/register_entity.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/login_repository.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/register_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginWebServices apiProvider;

  LoginRepositoryImpl({required this.apiProvider});
  @override
  Future<Either<Failure, LoginEntity>> login(
      {    required String username,
        required String password,
      }) async {
    try {
      final response = await  apiProvider.login(
        username: username,
        password: password,
      );
      return Right(response);
    }
    on NoInternetConnectionException catch (_) {
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
