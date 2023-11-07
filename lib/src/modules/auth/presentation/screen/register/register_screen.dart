import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/components/register_fields.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/controllers/register/register_cubit.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_values.dart';
import '../../../../../core/widgets/text_widget.dart';
import '../../components/form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RegisterCubit>(context);
  }
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      resizeToAvoidBottomInset: true,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          30.ph,
          Image.asset(
            ImageAssets.loginIcon,
            height: 95.83,
            width: 128.37,
            fit: BoxFit.contain,
          ),
          10.ph,
          const TextWidget(
            txt: AppStrings.register,
            fontSize: 19,
            color: AppColor.secondary,
            fontWeight: FontWeightManger.bold,
          ),
          30.ph,
          const TextWidget(
            txt: AppStrings.welcomeAndFillData,
            fontSize: 19,
            color: AppColor.textGrey,
            fontWeight: FontWeightManger.medium,
          ),
          30.ph,
          buildForm(),
        ],
      ),
    );
  }

  Widget buildForm() {
    return RegisterFields(
        formKey: _formKey,
        userNameController: _userNameController,
        emailController: _emailController,
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController);
  }
}
