part of 'cart_bloc.dart';

// Events

abstract class CartEvent {}

class CartGetInitialDataEvent extends CartEvent {
  final String userId;
  final int page;
  final int paginatedBy;

  CartGetInitialDataEvent({
    required this.userId,
    required this.page,
    required this.paginatedBy,
  });
}

class CartGetMoreDataEvent extends CartEvent {
  final String userId;
  final int page;
  final int paginatedBy;

  CartGetMoreDataEvent({
    required this.userId,
    required this.page,
    required this.paginatedBy,
  });
}

class CartAddtoOrRemoveFromEvent extends CartEvent {
  final String userId;
  final String foodId;

  CartAddtoOrRemoveFromEvent({
    required this.userId,
    required this.foodId,
  });
}

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartInitialLoadingState extends CartState {}

class CartGetMoreLoadingState extends CartState {}

class CartGetInitialDataState extends CartState {
  final ApiResponse<List<FoodModel>> response;
  CartGetInitialDataState({required this.response});
}

class CartGetMoreDataState extends CartState {
  final ApiResponse<List<FoodModel>> response;
  CartGetMoreDataState({required this.response});
}

class CartAddToOrRemoveFromState extends CartState {
  final ApiResponse<dynamic> response;
  CartAddToOrRemoveFromState({required this.response});
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState({required this.message});
}
