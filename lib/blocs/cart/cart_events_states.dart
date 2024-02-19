part of 'cart_bloc.dart';

// Events

abstract class CartEvent {}

class CartGetInitialDataEvent extends CartEvent {}

class CartGetCartListEvent extends CartEvent {}

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

class CartIsInCartEvent extends CartEvent {
  final String userId;
  final String foodId;

  CartIsInCartEvent({
    required this.userId,
    required this.foodId,
  });
}

// Increment and decrement cart quantity

class CartIncrementQtyEvent extends CartEvent {
  String foodId;
  CartIncrementQtyEvent({required this.foodId});
}

class CartDecrementQtyEvent extends CartEvent {
  String foodId;
  CartDecrementQtyEvent({
    required this.foodId,
  });
}

abstract class CartState {}

class CartGetCartListState extends CartState {
  final List<CartFoodModel> cartList;
  CartGetCartListState({required this.cartList});
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartInitialLoadingState extends CartState {}

class CartGetMoreLoadingState extends CartState {}

class CartGetInitialDataState extends CartState {
  final ApiResponse response;
  CartGetInitialDataState({required this.response});
}

class CartGetMoreDataState extends CartState {
  final ApiResponse<List<CartFoodModel>> response;
  CartGetMoreDataState({required this.response});
}

class CartEmptyState extends CartState {}

class CartAddToOrRemoveFromState extends CartState {
  final ApiResponse<dynamic> response;
  CartAddToOrRemoveFromState({required this.response});
}

class CartIsInCartState extends CartState {
  final Map<String, dynamic> response;
  CartIsInCartState({required this.response});
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState({required this.message});
}

// increment or decrement states
class CartIncrementQtyState extends CartState {
  final ApiResponse<dynamic> response;
  CartIncrementQtyState({required this.response});
}

class CartDecrementQtyState extends CartState {
  final ApiResponse<dynamic> response;
  CartDecrementQtyState({required this.response});
}

class CartUpdateQtyLoadingState extends CartState {}

class CartIncrementQtyErrorState extends CartState {}

class CartDecrementQtyErrorState extends CartState {}
