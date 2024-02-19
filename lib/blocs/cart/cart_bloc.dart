import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/cart/cart_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'cart_events_states.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartFoodModel> _cartList = [];
  CartBloc() : super(CartInitialState()) {
    on<CartGetCartListEvent>((event, emit) {
      emit(CartGetCartListState(cartList: _cartList));
    });

    on<CartGetInitialDataEvent>((event, emit) async {
      emit(CartInitialLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final foods = await CartController.getCartItemsByUserId(
            page: 1,
            paginatedBy: 50,
          );
          _cartList = foods.data;
          add(CartGetCartListEvent());
          if (foods.data.isEmpty) {
            emit(CartEmptyState());
          } else {
            emit(CartGetInitialDataState(response: foods));
          }
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

    // Increment or decrement event handling
    on<CartIncrementQtyEvent>((event, emit) async {
      emit(CartUpdateQtyLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await CartController.incrementQty(event.foodId);
          emit(CartIncrementQtyState(response: response));
        } else {
          emit(CartIncrementQtyErrorState());
        }
      } catch (error) {
        emit(CartIncrementQtyErrorState());
      }
    });

    on<CartDecrementQtyEvent>((event, emit) async {
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await CartController.decrementQty(event.foodId);
          emit(CartDecrementQtyState(response: response));
        } else {
          emit(CartDecrementQtyErrorState());
        }
      } catch (error) {
        emit(CartDecrementQtyErrorState());
      }
    });
  }
}
