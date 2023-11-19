part of 'session_bloc.dart';

// Events
abstract class SessionEvent {}

class SessionRefreshEvent extends SessionEvent {
  final String token, id;
  SessionRefreshEvent({required this.token, required this.id});
}

// States
abstract class SessionState {}

class SessionInitialState extends SessionState {}

class SessionLoadingState extends SessionState {}

class SessionHomeState extends SessionState {}

class SessionLoginState extends SessionState {}

class SessionErrorState extends SessionState {
  final String message;
  SessionErrorState({required this.message});
}
