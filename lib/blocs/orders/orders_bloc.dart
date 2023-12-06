import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/orders/orders_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/models/orders/orders_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'orders_events_states.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitialState()) {
    // Handle events
    on<OrderPlaceEvent>((event, emit) async {
      emit(OrdersLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final ApiResponse response = await OrdersController.placeOrder(
            address: event.address,
            totalPrice: event.totalPrice,
          );
          emit(OrdersPlaceState(response: response));
        } else {
          emit(OrdersErrorState(message: "No Internet Connection"));
        }
      } catch (_) {
        // throw some beautiful non technical error message
        throw Exception("Something went wrong");
      }
    });

    on<OrdersGetInitialDataEvent>((event, emit) async {
      emit(OrdersLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await OrdersController.getPlacedOrdersByUserId(
            page: 1,
            paginatedBy: 20,
          );
          emit(OrdersGetInitialDataState(response: response));
        } else {
          emit(OrdersErrorState(message: "No Internet Connection"));
        }
      } catch (_) {
        emit(OrdersErrorState(message: _.toString()));
      }
    });

    on<OrdersGetMoreDataEvent>((event, emit) async {
      emit(OrdersLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await OrdersController.getPlacedOrdersByUserId(
              page: event.page, paginatedBy: 10);
          emit(OrdersGetMoreDataState(response: response));
        } else {
          emit(OrdersErrorState(message: "No Internet Connection"));
        }
      } catch (_) {
        // throw some beautiful non technical error message
        throw Exception("Something went wrong");
      }
    });

    on<OrderFoodInitialEvent>((event, emit) async {
      emit(OrderFoodsLoadingInitialState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response =
              await OrdersController.getFoodsByOrderId(event.orderId);
          emit(OrderFoodsInitialDataState(response: response));
        } else {
          emit(OrdersErrorState(message: "No Internet Connection"));
        }
      } catch (_) {
        // throw some beautiful non technical error message
        throw Exception("Something went wrong");
      }
    });
  }
}
