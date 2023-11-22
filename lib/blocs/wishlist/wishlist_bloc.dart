import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/wishlist/wishlist_controller.dart';
import 'package:nb_utils/nb_utils.dart';

part 'wishlist_events_states.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitialState()) {
    on<WishlistAddOrRemoveEvent>((event, emit) async {
      emit(WishlistLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          await WishlistController.addOrRemoveItemToWishList(
            event.userId,
            event.foodId,
          );
          emit(WishlistLoadedState());
        } else {
          emit(WishlistErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(WishlistErrorState(message: error.toString()));
      }
    });
  }
}
