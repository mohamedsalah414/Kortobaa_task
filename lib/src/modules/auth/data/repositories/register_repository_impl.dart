import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/exception.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/auth/data/data_sources/register_datasource.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/register_entity.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterWebServices apiProvider;

  RegisterRepositoryImpl({required this.apiProvider});
  @override
  Future<Either<Failure, RegisterEntity>> register(
      {    required String username,
        required String firstName,
        required String lastName,
        required String email,
        required String password,
      }) async {
    try {
      final response = await  apiProvider.register(
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
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
