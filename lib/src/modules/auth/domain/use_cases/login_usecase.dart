import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/usecase/usecase.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/login_entity.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/register_entity.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/login_repository.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/register_repository.dart';

class LoginUseCase implements UseCase<LoginEntity, LoginParameters> {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, LoginEntity>> call(
      LoginParameters loginParameters) async {
    try {
      var result = await loginRepository.login(
        username: loginParameters.username,
        password: loginParameters.password,
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

class LoginParameters {
  final String username;
  final String password;

  LoginParameters({
    required this.username,
    required this.password,
  });
}
