import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_snackbars.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
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
  WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    super.initState();
    UserSecureStorage.fetchUserId().then((value) {
      userId = value;
      checkFavoriteStatus();
    });
  }

  checkFavoriteStatus() {
    wishlistBloc.add(
      WishlistIsfavoriteEvent(
        userId: userId.toString(),
        foodId: widget.food.sId.toString(),
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
    return Scaffold(
      appBar: BackAppbarWidget(title: widget.food.foodName),
      body: SingleChildScrollView(
        child: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listener: (context, state) {
            if (state is WishlistLoadingState) {
              isFavorite = !isFavorite;
            } else if (state is WishlistIsFavoriteFoodState) {
              isFavorite = state.isFavorite;
            } else if (state is WishlistAddOrRemoveSuccessState) {
              AppSnackbars.normal(context, state.response.message);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.food.foodName.toString(),
                            style: AppTextStyle.headings,
                            textAlign: TextAlign.left,
                          ),
                          IconButton(
                            onPressed: () {
                              wishlistBloc.add(
                                WishlistAddOrRemoveEvent(
                                  userId: userId.toString(),
                                  foodId: widget.food.sId.toString(),
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
                          )
                        ],
                      ),
                      10.height,
                      Text(
                        widget.food.description.toString(),
                        style: AppTextStyle.subHeading,
                        textAlign: TextAlign.left,
                      ),
                      10.height,
                      Text(
                        'food id: ${widget.food.sId.toString()}',
                        style: AppTextStyle.subHeading,
                        textAlign: TextAlign.left,
                      ),
                      10.height,
                      Text(
                        'user id: ${userId.toString()}',
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
  }
}
