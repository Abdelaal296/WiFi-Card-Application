part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class AddCategorySuccessState extends CategoriesState {
  final String message;

  AddCategorySuccessState({required this.message});
}

final class AddCategoryErrorState extends CategoriesState {
  final String error;

  AddCategoryErrorState({required this.error});
}

final class GetCategoriesLoadingState extends CategoriesState {}

final class GetCategoriesSuccessState extends CategoriesState {}

final class GetCategoriesFailureState extends CategoriesState {
  final String error;

  GetCategoriesFailureState({required this.error});
}

final class UpdateCategoryLoadingState extends CategoriesState {}

final class UpdateCategorySuccessState extends CategoriesState {
  final String message;

  UpdateCategorySuccessState({required this.message});
}

final class UpdateCategoryFailure extends CategoriesState {
  final String error;

  UpdateCategoryFailure({required this.error});
}

final class DeleteCategoryLoadingState extends CategoriesState {}

final class DeleteCategorySuccessState extends CategoriesState {
  final String message;

  DeleteCategorySuccessState({required this.message});
}

final class DeleteCategoryFailure extends CategoriesState {
  final String error;

  DeleteCategoryFailure({required this.error});
}
