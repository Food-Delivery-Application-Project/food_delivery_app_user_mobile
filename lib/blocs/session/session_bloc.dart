import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/session/session_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'session_events_states.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionInitialState()) {
    // Handle Events
    on<SessionRefreshEvent>((event, emit) async {
      emit(SessionLoadingState());
      try {
        emit(SessionLoadingState());
        var networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(SessionErrorState(message: "No Internet Connection"));
          return;
        }
        final ApiResponse response = await SessionController.refreshToken(
          id: event.id,
          token: event.token,
        );

        if (response.status == 200 || response.status == 201) {
          emit(SessionHomeState());
        } else {
          emit(SessionLoginState());
        }
      } catch (error) {
        emit(SessionErrorState(message: error.toString()));
      }
    });
  }
}
