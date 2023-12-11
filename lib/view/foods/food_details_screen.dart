import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/blocs/review/review_bloc.dart';
import 'package:food_delivery_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/app_snackbars.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/view/reviews/reviews_screen.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/buttons/outlined_button.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodModel food;
  const FoodDetailsScreen({Key? key, required this.food}) : super(key: key);

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  String? userId;
  bool isFavorite = false;
  bool? isInCart;
  bool? isLoading;

  // Blocs
  WishlistBloc wishlistBloc = WishlistBloc();
  CartBloc cartBloc = CartBloc();
  ReviewBloc ratingBloc = ReviewBloc();

  @override
  void initState() {
    super.initState();
    UserSecureStorage.fetchUserId().then((value) {
      userId = value;
      checkFavoriteStatus();
      checkCartStatus();
    });
  }

  checkFavoriteStatus() {
    wishlistBloc.add(
      WishlistIsfavoriteEvent(
        userId: userId.toString(),
        foodId: widget.food.foodId.toString(),
      ),
    );
  }

  checkCartStatus() {
    cartBloc.add(
      CartIsInCartEvent(
        userId: userId.toString(),
        foodId: widget.food.foodId.toString(),
      ),
    );
  }

  addToOrRemoveFromCart() {
    cartBloc.add(
      CartAddtoOrRemoveFromEvent(
        userId: userId.toString(),
        foodId: widget.food.foodId.toString(),
      ),
    );
  }

  @override
  void dispose() {
    wishlistBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listener: (context, state) {
        if (state is CartLoadingState) {
          isInCart = !isInCart!;
          AppDialogs.loadingDialog(context);
        } else if (state is CartAddToOrRemoveFromState) {
          Navigator.pop(context);
          AppSnackbars.normal(context, state.response.message);
        } else if (state is CartIsInCartState) {
          isInCart = state.response['isInCart'];
        } else if (state is CartErrorState) {
          isInCart = !isInCart!;
          Navigator.pop(context);
          AppSnackbars.normal(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: BackAppbarWidget(title: widget.food.foodName),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: isInCart == null
                ? const LoadingWidget()
                : isInCart == true
                    ? OutlinedButtonWidget(
                        caption: "Remove from cart",
                        onPressed: () {
                          addToOrRemoveFromCart();
                        })
                    : PrimaryButtonWidget(
                        caption: "Add to cart",
                        onPressed: () {
                          addToOrRemoveFromCart();
                        },
                      ),
          ),
          body: SingleChildScrollView(
            child: BlocConsumer<WishlistBloc, WishlistState>(
              bloc: wishlistBloc,
              listener: (context, state) {
                if (state is WishlistLoadingState) {
                  isFavorite = !isFavorite;
                } else if (state is WishlistIsFavoriteFoodLoadingState) {
                  isLoading = true;
                } else if (state is WishlistIsFavoriteFoodState) {
                  isLoading = false;
                  isFavorite = state.isFavorite;
                } else if (state is WishlistAddOrRemoveSuccessState) {
                  AppSnackbars.normal(context, state.response.message);
                  context
                      .read<WishlistBloc>()
                      .add(WishlistGetInitialDataEvent());
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.food.image.toString(),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  AppNavigator.goToPage(
                                    context: context,
                                    screen: ReviewsScreen(
                                      foodId: widget.food.foodId.toString(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Show all reviews",
                                  style: AppTextStyle.subHeading.copyWith(
                                    color: AppColors.success,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              isLoading == true
                                  ? const LoadingWidget()
                                  : Row(
                                      children: [
                                        Text(
                                          isFavorite == true
                                              ? "Favorite"
                                              : "Add to wishlist",
                                          style: AppTextStyle.subHeading
                                              .copyWith(color: AppColors.red),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            wishlistBloc.add(
                                              WishlistAddOrRemoveEvent(
                                                userId: userId.toString(),
                                                foodId: widget.food.foodId
                                                    .toString(),
                                              ),
                                            );
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor: AppColors.white,
                                            radius: 15,
                                            child: Icon(
                                              // do not apply isFavorite on every item in the grid view
                                              isFavorite == true
                                                  ? Ionicons.heart
                                                  : Ionicons.heart_outline,
                                              color: AppColors.red,
                                              size: 20,
                                              shadows: const [
                                                Shadow(
                                                  color: AppColors.black,
                                                  blurRadius: 1,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          10.height,
                          Text(
                            widget.food.description.toString(),
                            style: AppTextStyle.subHeading,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
