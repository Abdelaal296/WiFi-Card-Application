import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  static CategoriesCubit get(context) => BlocProvider.of(context);

  void addCategory({
    required String category,
    required String price,
    required String hours,
    required String validity,
    required String network_id,
    required String link,
  }) {
    DioHelper.postData(
      url: 'card/category/store',
      data: {
        'category': category,
        'price': price,
        'network_id': network_id,
        'hours': hours,
        'Validity': validity,
        'link': link,
      },
      token: token,
    ).then((value) {
      print(value.data['message']);
      getCategories(int.parse(network_id));
      emit(AddCategorySuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(AddCategoryErrorState(error: error));
    });
  }

  List<CategoryModel> categories = [];

  void getCategories(int id) async {
    emit(GetCategoriesLoadingState());
    await DioHelper.getData(
      url: 'card/categories/$id',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data']['card_categories'];
      categories = [];
      categories =
          userData!.map((data) => CategoryModel.fromJson(data)).toList();

      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategoriesFailureState(error: error.toString()));
    });
  }

  void updateCategory({
    required int cate_id,
    required String category,
    required String price,
    required String percent,
    required int network_id,
  }) {
    emit(UpdateCategoryLoadingState());
    DioHelper.postData(
      url: '/card/category/update/${cate_id}',
      data: {
        'category': category,
        'price': price,
        'shop_price_rate': percent,
        'network_id': network_id,
        '_method': 'PUT',
      },
      token: token,
    ).then((value) {
      getCategories(network_id);

      emit(UpdateCategorySuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(UpdateCategoryFailure(error: error));
    });
  }

  void deleteCategory({
    required int category_id,
    required int network_id,
  }) {
    emit(DeleteCategoryLoadingState());
    DioHelper.deleteData(
      url: 'card/category/delete/${category_id}',
      token: token,
    ).then((value) {
      print(category_id);
      print(value.data['message']);
      getCategories(network_id);
      emit(DeleteCategorySuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(DeleteCategoryFailure(error: error));
    });
  }
}
