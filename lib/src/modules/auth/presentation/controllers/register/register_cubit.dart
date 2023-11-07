import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/modules/auth/domain/entities/register_entity.dart';
import 'package:krtobaa_task/src/modules/auth/domain/use_cases/register_usecase.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase}) : super(RegisterInitial());

  Future<void> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final response = await registerUseCase.call(RegisterParameters(
          username: username,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password));
      emit(response.fold((failure) => RegisterError(message: failure.message!),
          (success) => RegisterLoaded(result: success)));
    } catch (e, s) {
      debugPrint('error is $e\nstack is $s');
      emit(RegisterError(message: e.toString()));
    }
  }
}
