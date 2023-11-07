import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/controllers/login/login_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/screens/home_screen.dart';
import 'package:krtobaa_task/src/modules/home_navigator/presentation/screens/home_navigator.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/widgets/text_widget.dart';
import '../screen/register/register_screen.dart';
import 'form_field.dart';

class LoginFields extends StatelessWidget {
  const LoginFields({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController userNameController,
    required TextEditingController passwordController,
    required this.context,
  })  : _formKey = formKey,
        _userNameController = userNameController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _userNameController;
  final TextEditingController _passwordController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            FormFieldWithTitle(
                title: AppStrings.userName,
                controller: _userNameController,
                textInputType: TextInputType.text,
                obscureText: false),
            20.ph,
            FormFieldWithTitle(
                title: AppStrings.password,
                controller: _passwordController,
                textInputType: TextInputType.text,
                obscureText: true),
            20.ph,
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LoginCubit>(context).login(
                      username: _userNameController.text,
                      password: _passwordController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.cyan,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const TextWidget(
                txt: AppStrings.loginButton,
                fontSize: 16,
                fontWeight: FontWeightManger.bold,
                color: AppColor.white,
              ),
            ),
            20.ph,
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextWidget(
                    txt: AppStrings.doNotHaveAccount,
                    fontSize: 16,
                    fontWeight: FontWeightManger.bold,
                    color: AppColor.textGrey,
                  ),
                  10.pw,
                  const TextWidget(
                    txt: AppStrings.register,
                    fontSize: 16,
                    fontWeight: FontWeightManger.bold,
                    color: AppColor.secondary,
                  ),
                ],
              ),
            ),
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginLoaded) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeNavigator()),
                      (route) => false);
                }
              },
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoginError) {
                    return Center(
                      child: TextWidget(
                        txt: state.message,
                        fontSize: 16,
                        fontWeight: FontWeightManger.bold,
                        color: AppColor.red,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ));
  }
}
