import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/category/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.black.withOpacity(0.5),
        ),
        child: Text(
          category.category.toString(),
          style: AppTextStyle.whiteButtonTextStyle,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.grey.withOpacity(0.2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            category.categoryThumbnail.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset(AppImages.logo),
          ),
        ),
      ),
    );
  }
}
