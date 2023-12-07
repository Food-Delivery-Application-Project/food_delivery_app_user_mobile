import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/wishlist/wishlist_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'wishlist_events_states.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitialState()) {
    on<WishlistAddOrRemoveEvent>((event, emit) async {
      emit(WishlistLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await WishlistController.addOrRemoveItemToWishList(
            event.userId,
            event.foodId,
          );
          emit(WishlistAddOrRemoveSuccessState(response: response));
        } else {
          emit(WishlistErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(WishlistErrorState(
            message: error.toString().replaceAll("Exception:", "")));
      }
    });

    on<WishlistGetInitialDataEvent>((event, emit) async {
      emit(WishlistInitalLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final foods = await WishlistController.getWishlistFoods(
            page: event.page,
            paginatedBy: event.paginatedBy,
          );
          emit(WishlistInitialLoadedState(foods: foods));
        } else {
          emit(WishlistErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(WishlistErrorState(
            message: error.toString().replaceAll("Exception:", "")));
      }
    });

    // Get more wishlist foods
    on<WishlistGetMoreDataEvent>((event, emit) async {
      try {
        emit(WishlistGetMoreLoadingState());
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final foods = await WishlistController.getWishlistFoods(
            page: event.page,
            paginatedBy: event.paginatedBy,
          );
          emit(WishlistGetMoreLoadedState(foods: foods));
        } else {
          emit(WishlistErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(WishlistErrorState(
            message: error.toString().replaceAll("Exception:", "")));
      }
    });

    // Is Favorite
    on<WishlistIsfavoriteEvent>((event, emit) async {
      emit(WishlistIsFavoriteFoodLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await WishlistController.isFavorite(
            event.userId,
            event.foodId,
          );
          emit(
            WishlistIsFavoriteFoodState(
                isFavorite: response.data.isFavorite ?? false),
          );
        } else {
          emit(WishlistIsFavoriteFoodState(isFavorite: false));
        }
      } catch (error) {
        emit(WishlistIsFavoriteFoodState(isFavorite: false));
      }
    });
  }
}
