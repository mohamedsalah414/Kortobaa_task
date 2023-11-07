import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/app_assets.dart';
import 'package:krtobaa_task/src/core/utils/app_colors.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/core/widgets/text_widget.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/controllers/login/login_cubit.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/screen/register/register_screen.dart';

import '../../../../../core/utils/app_values.dart';
import '../../components/form_field.dart';
import '../../components/login_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      resizeToAvoidBottomInset: true,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        height: context.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Image.asset(
              ImageAssets.loginIcon,
              height: 95.83,
              width: 128.37,
              fit: BoxFit.contain,
            ),
            const TextWidget(
              txt: AppStrings.login,
              fontSize: 19,
              color: AppColor.secondary,
              fontWeight: FontWeightManger.bold,
            ),
            const TextWidget(
              txt: AppStrings.pleaseLoginToBuy,
              fontSize: 19,
              color: AppColor.textGrey,
              fontWeight: FontWeightManger.medium,
            ),
            buildForm(),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return LoginFields(
        formKey: _formKey,
        userNameController: _userNameController,
        passwordController: _passwordController,
        context: context);
  }
}
