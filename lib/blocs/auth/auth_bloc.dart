import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/auth/auth_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/auth/auth_model.dart';
import 'package:food_delivery_app/models/auth/login_model.dart';
import 'package:food_delivery_app/models/auth/otp_model.dart';
import 'package:food_delivery_app/models/auth/signup_model.dart';
import 'package:food_delivery_app/models/user/register_user_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'auth_events_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    // Handle Events

    // Handle Register Event
    on<AuthEventRegister>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response = await AuthController.register(
            event.email,
            event.password,
          );
          emit(AuthRegistrationSuccessState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    on<AuthEventVerifyOtp>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.verifyOtp(event.email, event.otp);
          emit(AuthVerifyOtpState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Handle resend otp event
    on<AuthEventSendOtp>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response = await AuthController.sendOtp(event.email);
          emit(AuthSentOtpState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Handle complete profile event
    on<AuthEventCompleteProfile>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.completeProfile(user: event.user);
          emit(AuthCompleteProfileState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Handle Login Event
    on<AuthEventLogin>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.login(event.email, event.password);
          emit(AuthLoginState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });
  }
}
