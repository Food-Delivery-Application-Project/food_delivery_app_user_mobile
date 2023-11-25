import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/cart/cart_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'cart_events_states.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<CartGetInitialDataEvent>((event, emit) async {
      emit(CartInitialLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final ApiResponse<List<FoodModel>> foods =
              await CartController.getCartItemsByUserId(
            event.userId,
            page: event.page,
            paginatedBy: event.paginatedBy,
          );
          emit(CartGetInitialDataState(response: foods));
        } else {
          emit(CartErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(CartErrorState(
            message: error.toString().replaceAll("Exception:", "")));
      }
    });

    on<CartAddtoOrRemoveFromEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final ApiResponse<dynamic> response =
              await CartController.addToOrRemoveFromCart(
                  event.userId, event.foodId);
          emit(CartAddToOrRemoveFromState(response: response));
        } else {
          emit(CartErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(CartErrorState(
            message: error.toString().replaceAll("Exception:", "")));
      }
    });

    on<CartIsInCartEvent>((event, emit) async {
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response =
              await CartController.isInCart(event.userId, event.foodId);
          emit(CartIsInCartState(response: response));
        } else {
          emit(CartErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(CartErrorState(
            message: error.toString().replaceAll("Exception:", "")));
      }
    });
  }
}
