part of 'story_bloc.dart';

//Events
abstract class StoryEvent {}

class StoryGetAllEvent extends StoryEvent {}

//States
abstract class StoryState {}

class StoryInitialState extends StoryState {}

class StoryLoadingState extends StoryState {}

class StoryGetAllState extends StoryState {
  final ApiResponse response;
  StoryGetAllState({required this.response});
}

class StoryErrorState extends StoryState {
  final String message;
  StoryErrorState({required this.message});
}