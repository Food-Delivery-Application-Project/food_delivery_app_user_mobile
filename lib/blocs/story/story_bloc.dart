import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/stories/stories_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'story_events_states.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitialState()) {
    on<StoryEvent>((event, emit) async {
      if (event is StoryGetAllEvent) {
        emit(StoryLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            // APi logic
            final response = await StoriesController.fetchAllStories();
            emit(StoryGetAllState(response: response));
          } else {
            emit(StoryErrorState(message: "No Internet Connection"));
          }
        } catch (error) {
          emit(StoryErrorState(message: error.toString()));
        }
      }
    });
  }
}
