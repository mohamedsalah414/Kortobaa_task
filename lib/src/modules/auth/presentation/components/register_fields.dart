import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/controllers/register/register_cubit.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/screen/login/login_screen.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/widgets/text_widget.dart';
import 'form_field.dart';

class RegisterFields extends StatelessWidget {
  const RegisterFields({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController userNameController,
    required TextEditingController emailController,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) : _formKey = formKey, _userNameController = userNameController, _emailController = emailController, _firstNameController = firstNameController, _lastNameController = lastNameController, _passwordController = passwordController, _confirmPasswordController = confirmPasswordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _userNameController;
  final TextEditingController _emailController;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;

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
                title: AppStrings.email,
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                obscureText: false),
            20.ph,
            FormFieldWithTitle(
                title: AppStrings.firstName,
                controller: _firstNameController,
                textInputType: TextInputType.name,
                obscureText: false),
            20.ph,
            FormFieldWithTitle(
                title: AppStrings.lastName,
                controller: _lastNameController,
                textInputType: TextInputType.name,
                obscureText: false),
            20.ph,
            FormFieldWithTitle(
                title: AppStrings.password,
                controller: _passwordController,
                textInputType: TextInputType.visiblePassword,
                obscureText: true),
            20.ph,
            FormFieldWithTitle(
                title: AppStrings.confirmPassword,
                controller: _confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                obscureText: true),
            20.ph,
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<RegisterCubit>(context).register(
                      username: _userNameController.text,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text);

                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.cyan,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const TextWidget(
                txt: AppStrings.register,
                fontSize: 16,
                fontWeight: FontWeightManger.bold,
                color: AppColor.white,
              ),
            ),
            20.ph,
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginPage()));
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
                    txt: AppStrings.haveAccount,
                    fontSize: 16,
                    fontWeight: FontWeightManger.bold,
                    color: AppColor.textGrey,
                  ),
                  10.pw,
                  const TextWidget(
                    txt: AppStrings.loginButton,
                    fontSize: 16,
                    fontWeight: FontWeightManger.bold,
                    color: AppColor.secondary,
                  ),
                ],
              ),
            ),
      BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoaded) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const LoginPage()));
          }
        },
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            if (state is RegisterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RegisterError) {
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
