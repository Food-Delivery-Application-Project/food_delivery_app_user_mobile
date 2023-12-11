part of 'user_bloc.dart';

// Events
abstract class UserEvent {}

class UserGetDetailsEvent extends UserEvent {}

// States
abstract class UserState {}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserGetDataState extends UserState {
  final ApiResponse<UserModel> response;
  UserGetDataState({required this.response});
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
