part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class WishlistAddOrRemoveEvent extends WishlistEvent {
  final String userId, foodId;
  WishlistAddOrRemoveEvent({required this.userId, required this.foodId});
}

class WishlistGetInitialDataEvent extends WishlistEvent {
  final String userId;
  final int page, paginatedBy;
  WishlistGetInitialDataEvent(
      {required this.userId, required this.page, required this.paginatedBy});
}

class WishlistGetMoreDataEvent extends WishlistEvent {
  final String userId;
  final int page, paginatedBy;
  WishlistGetMoreDataEvent(
      {required this.userId, required this.page, required this.paginatedBy});
}

class WishlistIsfavoriteEvent extends WishlistEvent {
  final String userId, foodId;
  WishlistIsfavoriteEvent({required this.userId, required this.foodId});
}

abstract class WishlistState {}

class WishlistInitialState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistAddOrRemoveSuccessState extends WishlistState {
  final ApiResponse response;
  WishlistAddOrRemoveSuccessState({required this.response});
}

class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState({required this.message});
}

// get wishlisted foods
class WishlistInitalLoadingState extends WishlistState {}

class WishlistGetMoreLoadingState extends WishlistState {}

class WishlistInitialLoadedState extends WishlistState {
  final ApiResponse<List<FoodModel>> foods;
  WishlistInitialLoadedState({required this.foods});
}

class WishlistGetMoreLoadedState extends WishlistState {
  final ApiResponse<List<FoodModel>> foods;
  WishlistGetMoreLoadedState({required this.foods});
}

class WishlistInitialErrorState extends WishlistState {
  final String message;
  WishlistInitialErrorState({required this.message});
}

// Is favorite food
class WishlistIsFavoriteFoodState extends WishlistState {
  final bool isFavorite;
  WishlistIsFavoriteFoodState({required this.isFavorite});
}
