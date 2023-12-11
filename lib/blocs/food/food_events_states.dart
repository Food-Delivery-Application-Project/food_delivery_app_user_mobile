part of 'food_bloc.dart';

// Events
abstract class FoodEvent {}

class FoodGetByCategoryIdEvent extends FoodEvent {
  int categoryId, page, paginatedBy;
  FoodGetByCategoryIdEvent(this.categoryId, this.page, this.paginatedBy);
}

class FoodGetMoreByCategoryIdEvent extends FoodEvent {
  int categoryId, page, paginatedBy;
  FoodGetMoreByCategoryIdEvent(this.categoryId, this.page, this.paginatedBy);
}

//States
abstract class FoodState {}

class FoodInitialState extends FoodState {}

class FoodLoadingState extends FoodState {}

class FoodMoreLoadingState extends FoodState {}

class FoodLoadedState extends FoodState {
  ApiResponse<List<FoodModel>> foodList;
  FoodLoadedState(this.foodList);
}

class FoodErrorState extends FoodState {
  String message;
  FoodErrorState(this.message);
}

class RandomFoodEvent extends FoodEvent {}

class RandomFoodLoadedState extends FoodState {
  ApiResponse<List<FoodModel>> food;
  RandomFoodLoadedState(this.food);
}
