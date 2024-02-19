part of 'user_bloc.dart';

// Events
abstract class UserEvent {}

class UserGetDetailsEvent extends UserEvent {}

class UserGetEvent extends UserEvent {}

// States
abstract class UserState {}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserGetDataState extends UserState {
  final ApiResponse<UserModel> response;
  UserGetDataState({required this.response});
}

class UserGetState extends UserState {
  final UserModel user;
  UserGetState({required this.user});
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
