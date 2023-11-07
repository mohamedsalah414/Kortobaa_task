import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/core/usecase/usecase.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/register_entity.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/register_repository.dart';


class RegisterUseCase implements UseCase<RegisterEntity, RegisterParameters> {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParameters registerParameters) async {
    try {
      var result = await registerRepository.register(
        username: registerParameters.username,
        firstName: registerParameters.firstName,
        lastName: registerParameters.lastName,
        email: registerParameters.email,
        password: registerParameters.password,
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

class RegisterParameters {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterParameters({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}