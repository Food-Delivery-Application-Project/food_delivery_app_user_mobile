import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/review/rewiew_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'review_events_states.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitialState()) {
    on<ReviewPostEvent>((event, emit) async {
      emit(ReviewLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response =
              await ReviewController.postReview(event.foodId, event.text);
          emit(ReviewPostSuccessState(response));
        } else {
          emit(ReviewErrorState(message: "No Internet Connection"));
        }
      } catch (_) {
        emit(ReviewErrorState(message: _.toString()));
      }
    });

    on<ReviewGetInitialEvent>((event, emit) async {
      emit(ReviewDataLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await ReviewController.getAllReviews(
            event.foodId,
            page: 1,
            paginatedBy: 20,
          );
          if (response.data.isNotEmpty) {
            emit(ReviewSuccessState(response));
          } else {
            emit(ReviewEmptyState());
          }
        } else {
          emit(ReviewDataErrorState(message: "No Internet Connection"));
        }
      } catch (_) {
        emit(ReviewDataErrorState(message: _.toString()));
      }
    });
  }
}
