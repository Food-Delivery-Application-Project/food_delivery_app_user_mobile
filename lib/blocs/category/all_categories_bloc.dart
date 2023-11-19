import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/category/category_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/category/category_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'all_categories_events_states.dart';

class AllCategoriesBloc extends Bloc<AllCategoriesEvent, AllCategoriesState> {
  AllCategoriesBloc() : super(AllCategoriesInitialState()) {
    // Handle events
    on<GetAllCategoriesEvent>((event, emit) async {
      emit(AllCategoriesLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final ApiResponse<List<CategoryModel>> categories =
              await CategoryController.getAllCategories();
          emit(AllCategoriesLoadedState(categories: categories));
        } else {
          emit(AllCategoriesErrorState(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(AllCategoriesErrorState(message: error.toString()));
      }
    });
  }
}
