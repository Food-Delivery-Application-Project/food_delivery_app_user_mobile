part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class WishlistAddOrRemoveEvent extends WishlistEvent {
  final String userId, foodId;
  WishlistAddOrRemoveEvent({required this.userId, required this.foodId});
}

abstract class WishlistState {}

class WishlistInitialState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedState extends WishlistState {}

class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState({required this.message});
}
