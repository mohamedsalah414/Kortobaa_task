import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/config/datasource/web_services/web_services.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/auth/data/models/login_model.dart';

import '../../domain/entities/login_entity.dart';

abstract class LoginWebServices {
  Future<LoginEntity> login({
    required String username,
    required String password,

  });

}
class LoginWebServicesImpl implements LoginWebServices {
  final WebServices webServices;

  LoginWebServicesImpl({required this.webServices});
  @override
  Future<LoginEntity> login({
    required String username,
    required String password,
  }) async {

    final response = await webServices.dio.post(
      ApiUrls.postLogin,
      data: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      try {
        final responseData = response.data;
        debugPrint(
            'API request success with status code ${response.statusCode}');
        final loggedData = LoginModel.fromJson(responseData);
        return loggedData;
      } catch (e, s) {
        debugPrint('e is $e \ns is $s');
        return Future.error(e);
      }
    } else {
      debugPrint('API request failed with status code ${response.statusCode}');
      return Future.error(
        'API request failed with status code ${response.statusCode}',
      );
    }
  }

}