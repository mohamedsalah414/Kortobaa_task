import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:krtobaa_task/src/config/datasource/web_services/web_services.dart';
import 'package:krtobaa_task/src/modules/auth/data/data_sources/login_datasource.dart';
import 'package:krtobaa_task/src/modules/auth/data/data_sources/register_datasource.dart';
import 'package:krtobaa_task/src/modules/auth/data/repositories/login_repository_impl.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/login_repository.dart';
import 'package:krtobaa_task/src/modules/auth/domain/repositories/register_repository.dart';
import 'package:krtobaa_task/src/modules/auth/domain/use_cases/login_usecase.dart';
import 'package:krtobaa_task/src/modules/auth/domain/use_cases/register_usecase.dart';
import 'package:krtobaa_task/src/modules/auth/presentation/controllers/login/login_cubit.dart';
import 'package:krtobaa_task/src/modules/home/data/data_sources/categories_datasource.dart';
import 'package:krtobaa_task/src/modules/home/data/data_sources/products_datasource.dart';
import 'package:krtobaa_task/src/modules/home/data/repositories/categories_repository_impl.dart';
import 'package:krtobaa_task/src/modules/home/data/repositories/products_repository_impl.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/categories_repository.dart';
import 'package:krtobaa_task/src/modules/home/domain/repositories/products_repository.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_all_categories_usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_all_products_usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_categories_by_id_usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_products_by_category_id_usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_products_by_id.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/cart/cart_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/categories_cubit/categories_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/favourites/favourites_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/products_cubit/products_cubit.dart';

import 'src/modules/auth/data/repositories/register_repository_impl.dart';
import 'src/modules/auth/presentation/controllers/register/register_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // register services
  sl.registerLazySingleton<WebServices>(() => WebServices());

  sl.registerLazySingleton<RegisterWebServices>(() => RegisterWebServicesImpl(
        webServices: sl(),
      ));
  sl.registerLazySingleton<LoginWebServices>(() => LoginWebServicesImpl(
        webServices: sl(),
      ));
  sl.registerLazySingleton<CategoriesWebServices>(
      () => CategoriesWebServicesImpl(
            webServices: sl(),
          ));
  sl.registerLazySingleton<ProductsWebServices>(() => ProductsWebServicesImpl(
        webServices: sl(),
      ));

  // Use cases

  sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(registerRepository: sl()));
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton<GetAllCategoriesUseCase>(
      () => GetAllCategoriesUseCase(categoriesRepository: sl()));
  sl.registerLazySingleton<GetCategoriesByIdUseCase>(
      () => GetCategoriesByIdUseCase(categoriesRepository: sl()));
  sl.registerLazySingleton<GetAllProductsUseCase>(
      () => GetAllProductsUseCase(productsRepository: sl()));
  sl.registerLazySingleton<GetProductsByCategoryIdUseCase>(
      () => GetProductsByCategoryIdUseCase(productsRepository: sl()));
  sl.registerLazySingleton<GetProductsByIdUseCase>(
      () => GetProductsByIdUseCase(productsRepository: sl()));

  // register repositories
  sl.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(apiProvider: sl()));
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(apiProvider: sl()));
  sl.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(apiProvider: sl()));
  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(apiProvider: sl()));

  // register blocs
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(
        registerUseCase: sl(),
      ));
  sl.registerFactory<LoginCubit>(() => LoginCubit(
        loginUseCase: sl(),
      ));
  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit(
        getAllCategoriesUseCase: sl(),
        getCategoriesByIdUseCase: sl(),
      ));
  sl.registerFactory<ProductsCubit>(() => ProductsCubit(
        getAllProductsUseCase: sl(),
        getProductsByIdUseCase: sl(),
        getProductsByCategoryIdUseCase: sl(),
      ));
  sl.registerFactory<FavouritesCubit>(() => FavouritesCubit());
  sl.registerFactory<CartCubit>(() => CartCubit());
  /*  sl.registerFactory<WeatherCubit>(
      () => WeatherCubit(getWeatherLatLon: sl(), getWeatherCityName: sl()));
  sl.registerFactory<FavouriteCubit>(
    () => FavouriteCubit(),
  );*/
}
