import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/user/user_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/user/user_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'user_events_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitState()) {
    on<UserEvent>(
      (event, emit) async {
        if (event is UserGetDetailsEvent) {
          emit(UserLoadingState());
          try {
            var networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final response = await UserController.fetchUserDetails();
              emit(UserGetDataState(response: response));
            } else {
              emit(UserErrorState("No internet connection"));
            }
          } catch (error) {
            emit(UserErrorState(error.toString()));
          }
        }
      },
    );
  }
}
