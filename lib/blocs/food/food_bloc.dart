import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/foods/foods_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'food_events_states.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitialState()) {
    // Handle events
    on<FoodGetByCategoryIdEvent>((event, emit) async {
      emit(FoodLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final ApiResponse<List<FoodModel>> foods =
              await FoodController.getFoodItemByCategoryId(
            event.categoryId,
            page: event.page,
            paginatedBy: event.paginatedBy,
          );
          emit(FoodLoadedState(foods));
        } else {
          emit(FoodErrorState("No Internet Connection"));
        }
      } catch (error) {
        emit(FoodErrorState(error.toString()));
      }
    });
  }
}
