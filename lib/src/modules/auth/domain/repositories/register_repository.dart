import 'package:dartz/dartz.dart';
import 'package:krtobaa_task/src/core/error/failure.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/register_entity.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterEntity>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

}