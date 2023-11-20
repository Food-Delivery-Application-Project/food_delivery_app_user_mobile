import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridTile(
        header: Shimmer(
          gradient: LinearGradient(
            colors: [
              AppColors.darkGrey.withOpacity(0.3),
              AppColors.lightGrey,
              AppColors.darkGrey.withOpacity(0.3),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          child: Container(
            height: 30,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: AppColors.darkGrey,
            ),
            child: Text(
              "Category",
              style: AppTextStyle.headings.copyWith(
                color: AppColors.white,
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lightGrey,
            ),
          ),
        ));
  }
}
