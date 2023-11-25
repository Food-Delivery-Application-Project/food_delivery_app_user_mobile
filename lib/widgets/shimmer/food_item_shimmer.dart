import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class FoodItemShimmer extends StatelessWidget {
  const FoodItemShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridTile(
        header: Shimmer(
          gradient: LinearGradient(
            colors: [
              AppColors.darkGrey.withOpacity(0.3),
              AppColors.lightGrey,
              AppColors.darkGrey.withOpacity(0.3),
            ],
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ),
        child: Shimmer(
          gradient: LinearGradient(
            colors: [
              AppColors.darkGrey.withOpacity(0.3),
              AppColors.lightGrey,
              AppColors.darkGrey.withOpacity(0.3),
            ],
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
