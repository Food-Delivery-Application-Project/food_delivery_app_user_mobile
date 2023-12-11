part of 'review_bloc.dart';

abstract class ReviewEvent {}

class ReviewPostEvent extends ReviewEvent {
  final String text;
  final String foodId;
  ReviewPostEvent({required this.foodId, required this.text});
}

class ReviewGetInitialEvent extends ReviewEvent {
  final String foodId;
  ReviewGetInitialEvent({required this.foodId});
}

class ReviewGetMoreEvent extends ReviewEvent {
  final String foodId;
  int page, paginatedBy;
  ReviewGetMoreEvent({
    required this.foodId,
    required this.page,
    required this.paginatedBy,
  });
}

// States

abstract class ReviewState {}

class ReviewInitialState extends ReviewState {}

class ReviewLoadingState extends ReviewState {}

class ReviewDataLoadingState extends ReviewState {}

class ReviewSuccessState extends ReviewState {
  final ApiResponse response;
  ReviewSuccessState(this.response);
}

class ReviewEmptyState extends ReviewState {}

class ReviewPostSuccessState extends ReviewState {
  final ApiResponse response;
  ReviewPostSuccessState(this.response);
}

class ReviewErrorState extends ReviewState {
  final String message;

  ReviewErrorState({required this.message});
}

class ReviewDataErrorState extends ReviewState {
  final String message;

  ReviewDataErrorState({required this.message});
}
