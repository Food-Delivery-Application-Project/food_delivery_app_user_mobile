import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.black.withOpacity(0.5),
        ),
        child: Text("Category", style: AppTextStyle.whiteButtonTextStyle),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade100,
          image: const DecorationImage(
            image: AssetImage(AppImages.logo),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
