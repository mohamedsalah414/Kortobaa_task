import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/config/datasource/web_services/web_services.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';

import '../../domain/entities/register_entity.dart';
import '../models/register_model.dart';

abstract class RegisterWebServices {
  Future<RegisterEntity> register({
     required String username,
     required String firstName,
      required String lastName,
      required String email,
      required String password,

  });

}
class RegisterWebServicesImpl implements RegisterWebServices {
  final WebServices webServices;

  RegisterWebServicesImpl({required this.webServices});
  @override
  Future<RegisterEntity> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {

    final response = await webServices.dio.post(
      ApiUrls.postRegister,
      data: {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      try {
        final responseData = response.data;
        debugPrint(
            'API request success with status code ${response.statusCode}');
        final registerData = RegisterModel.fromJson(responseData);
        return registerData;
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