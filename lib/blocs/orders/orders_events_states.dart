part of 'orders_bloc.dart';

// Events
abstract class OrdersEvent {}

class OrderPlaceEvent extends OrdersEvent {
  final double totalPrice;
  final String address;

  OrderPlaceEvent({
    required this.totalPrice,
    required this.address,
  });
}

class OrdersGetInitialDataEvent extends OrdersEvent {}

class OrdersGetMoreDataEvent extends OrdersEvent {
  final int page;
  final int paginatedBy;

  OrdersGetMoreDataEvent({
    required this.page,
    required this.paginatedBy,
  });
}

// States
abstract class OrdersState {}

class OrdersInitialState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersErrorState extends OrdersState {
  final String message;

  OrdersErrorState({
    required this.message,
  });
}

class OrdersPlaceState extends OrdersState {
  final ApiResponse response;

  OrdersPlaceState({
    required this.response,
  });
}

class OrdersGetMoreDataState extends OrdersState {
  final ApiResponse<List<OrdersModel>> response;

  OrdersGetMoreDataState({
    required this.response,
  });
}

class OrdersGetInitialDataState extends OrdersState {
  final ApiResponse<List<OrdersModel>> response;

  OrdersGetInitialDataState({
    required this.response,
  });
}
