import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/foods/food_details_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class FoodItem extends StatefulWidget {
  final FoodModel foodModel;
  const FoodItem({Key? key, required this.foodModel}) : super(key: key);

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  String? userId;
  // bool isFavorite = false;
  // WishlistBloc wishlistBloc = WishlistBloc();

  // @override
  // void initState() {
  //   super.initState();
  //   UserSecureStorage.fetchUserId().then((value) {
  //     userId = value;
  //     checkFavoriteStatus();
  //   });
  // }

  // checkFavoriteStatus() {
  //   wishlistBloc.add(
  //     WishlistIsfavoriteEvent(
  //       userId: userId.toString(),
  //       foodId: widget.foodModel.sId.toString(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.goToPage(
          context: context,
          screen: FoodDetailsScreen(food: widget.foodModel),
        );
      },
      child: Column(
        children: [
          Flexible(
            child: GridTile(
              header: Container(
                // give some gradient color
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkBackground,
                      AppColors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: GridTileBar(
                  title: AutoSizeText(
                    widget.foodModel.foodName.toString(),
                    style: AppTextStyle.foodItemName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {
                  //     wishlistBloc.add(
                  //       WishlistAddOrRemoveEvent(
                  //         userId: userId.toString(),
                  //         foodId: widget.foodModel.sId.toString(),
                  //       ),
                  //     );
                  //     // update is favorite
                  //     wishlistBloc.add(
                  //       WishlistIsfavoriteEvent(
                  //         userId: userId.toString(),
                  //         foodId: widget.foodModel.sId.toString(),
                  //       ),
                  //     );
                  //   },
                  //   icon: BlocConsumer<WishlistBloc, WishlistState>(
                  //     bloc: wishlistBloc,
                  //     listener: (context, state) {
                  //       if (state is WishlistIsFavoriteFoodState) {
                  //         isFavorite = state.isFavorite;
                  //       } else if (state is WishlistLoadingState) {
                  //         isFavorite = !isFavorite;
                  //       } else if (state is WishlistErrorState) {
                  //         isFavorite = !isFavorite;
                  //       }
                  //     },
                  //     builder: (context, state) {
                  //       return CircleAvatar(
                  //         backgroundColor: AppColors.white,
                  //         radius: 15,
                  //         child: Icon(
                  //           // do not apply isFavorite on every item in the grid view
                  //           isFavorite
                  //               ? Ionicons.heart
                  //               : Ionicons.heart_outline,
                  //           color: AppColors.red,
                  //           size: 20,
                  //           shadows: const [
                  //             Shadow(
                  //               color: AppColors.black,
                  //               blurRadius: 1,
                  //               offset: Offset(0, 1),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  shape: BoxShape.rectangle,
                  color: AppColors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.foodModel.image.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(AppImages.logo),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: context.width(),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.foodModel.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    AutoSizeText(
                      "PKR: ${widget.foodModel.price}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        // delete the text
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Ionicons.star,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        const SizedBox(width: 5),
                        AutoSizeText(
                          "5",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
