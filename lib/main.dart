import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/controllers/login/login_cubit.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/screen/login/login_screen.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/cart/cart_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/favourites/favourites_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/screens/home_screen.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/categories_cubit/categories_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/products_cubit/products_cubit.dart';
import 'package:krtobaa_task/src/modules/splash/presentation/screens/spalsh_screen.dart';

import 'dependency_injection.dart' as di;
import 'src/core/themes/app_theme.dart';
import 'src/core/utils/app_colors.dart';
import 'src/core/utils/app_strings.dart';
import 'src/modules/auth/presentation/controllers/register/register_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<RegisterCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<CategoriesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<FavouritesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<CartCubit>(),
        ),
      ],
      child: MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar', 'EG'),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightThemeData,
          home: const SplashScreen()),
    );
  }
}
