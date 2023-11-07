import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krtobaa_task/src/core/services/shared_preferences.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/products_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_all_products_usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_products_by_category_id_usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_products_by_id.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductsByIdUseCase getProductsByIdUseCase;
  final GetProductsByCategoryIdUseCase getProductsByCategoryIdUseCase;

  String token = '';

  ProductsCubit({
    required this.getAllProductsUseCase,
    required this.getProductsByIdUseCase,
    required this.getProductsByCategoryIdUseCase,
  }) : super(ProductsInitial());

  getToken() {
    SharedPreferencesService.getInstance().then((value) {
      // token = value.getValue('accessToken')!;
      token = value.getValue('refreshToken')!;
    });
  }

  init() async {
    // getAllProducts();
    await getMostPopularProducts();
    await getMostRecentProducts();
  }

  Future<void> getAllProducts() async {
    getToken();
    emit(ProductsLoading());
    final result = await getAllProductsUseCase.call(
      ProductsParameters(
        token: token,
      ),
    );
    result.fold(
      (failure) => emit(ProductsError(message: failure.message!)),
      (success) => emit(AllProductsLoaded(productsEntity: success)),
    );
  }

  Future<void> getProductsByCategoryId(int catId) async {
    getToken();
    emit(ProductsLoading());
    final result = await getProductsByCategoryIdUseCase.call(
      ProductsByCategoryIdParameters(
        token: token,
        catId: catId,
      ),
    );
    result.fold(
      (failure) => emit(ProductsError(message: failure.message!)),
      (success) => emit(ProductsByCategoryId(productsEntity: success)),
    );
  }

  Future<void> getMostRecentProducts() async {
    getToken();
    emit(MostRecentProductsLoading());
    final result = await getProductsByCategoryIdUseCase.call(
      ProductsByCategoryIdParameters(
        token: token,
        catId: 5,
      ),
    );
    result.fold(
      (failure) => emit(MostRecentProductsError(message: failure.message!)),
      (success) => emit(MostRecentProducts(productsEntity: success)),
    );
  }

  Future<void> getMostPopularProducts() async {
    getToken();
    emit(MostPopularProductsLoading());
    final result = await getProductsByCategoryIdUseCase.call(
      ProductsByCategoryIdParameters(
        token: token,
        catId: 1,
      ),
    );
    result.fold(
      (failure) => emit(MostPopularProductsError(message: failure.message!)),
      (success) => emit(MostPopularProducts(productsEntity: success)),
    );
  }

  Future<void> getProductsById(int id) async {
    getToken();
    emit(ProductsLoading());
    final result = await getProductsByIdUseCase.call(
      ProductsByIdParameters(
        token: token,
        id: id,
      ),
    );
    result.fold(
      (failure) => emit(ProductsError(message: failure.message!)),
      (success) => emit(ProductsIdLoaded(result: success)),
    );
  }
}
