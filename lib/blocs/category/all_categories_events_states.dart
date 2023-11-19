part of 'all_categories_bloc.dart';

// Events
abstract class AllCategoriesEvent {}

class GetAllCategoriesEvent extends AllCategoriesEvent {}

// States
abstract class AllCategoriesState {}

class AllCategoriesInitialState extends AllCategoriesState {}

class AllCategoriesLoadingState extends AllCategoriesState {}

class AllCategoriesLoadedState extends AllCategoriesState {
  final ApiResponse<List<CategoryModel>> categories;

  AllCategoriesLoadedState({required this.categories});
}

class AllCategoriesErrorState extends AllCategoriesState {
  final String message;

  AllCategoriesErrorState({required this.message});
}
