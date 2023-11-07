import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krtobaa_task/src/core/services/shared_preferences.dart';
import 'package:krtobaa_task/src/modules/home/domain/entities/categories_entity.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_all_categories_usecase.dart';
import 'package:krtobaa_task/src/modules/home/domain/use_cases/get_categories_by_id_usecase.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesByIdUseCase getCategoriesByIdUseCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  String token = '';

  CategoriesCubit({
    required this.getCategoriesByIdUseCase,
    required this.getAllCategoriesUseCase,
  }) : super(CategoriesInitial());
  getToken(){
    SharedPreferencesService.getInstance().then((value) {
      token = value.getValue('accessToken')!;
    });
  }
  init(){
    getAllCategories(token);
  }
  Future<void> getAllCategories(String token) async {
    getToken();
    emit(CategoriesLoading());
    final result = await getAllCategoriesUseCase.call(
      CategoriesParameters(
        token: token,
      ),
    );
    result.fold(
      (failure) => emit(CategoriesError(message: failure.message!)),
      (success) => emit(AllCategoriesLoaded(categoriesEntity: success)),
    );
  }

  Future<void> getCategoriesById(String token, int id) async {
    getToken();
    emit(CategoriesLoading());
    final result = await getCategoriesByIdUseCase.call(
      CategoriesByIdParameters(
        token: token,
        id: id,
      ),
    );
    result.fold(
      (failure) => emit(CategoriesError(message: failure.message!)),
      (success) => emit(CategoriesIdLoaded(result: success)),
    );
  }
}
