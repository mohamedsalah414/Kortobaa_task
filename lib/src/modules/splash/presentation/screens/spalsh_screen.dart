import 'package:flutter/material.dart';
import 'package:krtobaa_task/src/core/services/shared_preferences.dart';
import 'package:krtobaa_task/src/core/utils/app_assets.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/screen/login/login_screen.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../home_navigator/presentation/screens/home_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoggedIn();
    Future.delayed(const Duration(seconds: 3)).then((value) => navigate());
  }

  bool isLoggedIn = false;

  checkLoggedIn() {
    SharedPreferencesService.getInstance().then((value) {
      if(value.getValue('isLogin') == null){
        value.saveValue('isLogin', false);
      }
      isLoggedIn = value.getValue('isLogin');
      debugPrint('isLoggedIn: $isLoggedIn');

    });
  }

  navigate() {
    if (isLoggedIn) {
      debugPrint('navigate to HomeScreen');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeNavigator()),
          (route) => false);
    } else {
      debugPrint('navigate to LoginPage');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        ImageAssets.loginIcon,
        fit: BoxFit.contain,
        height: 150,
        width: 150,
      )),
    );
  }
}
