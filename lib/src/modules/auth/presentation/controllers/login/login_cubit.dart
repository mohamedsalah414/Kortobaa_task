import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/core/services/shared_preferences.dart';
import 'package:krtobaa_task/src/modules/auth/domain/use_cases/login_usecase.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/login_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final response = await loginUseCase
          .call(LoginParameters(username: username, password: password));
      emit(response.fold((failure) => LoginError(message: failure.message!),
          (success) {
            debugPrint('access is ${success.access}\nrefresh is ${success.refresh}');
        SharedPreferencesService.getInstance().then((value) {
          value.saveValue('accessToken', success.access);
          value.saveValue('refreshToken', success.refresh);
          value.saveValue('isLogin', true);
        });
        return LoginLoaded(result: success);
      }));
    } catch (e, s) {
      debugPrint('error is $e\nstack is $s');
      emit(LoginError(message: e.toString()));
    }
  }
}
