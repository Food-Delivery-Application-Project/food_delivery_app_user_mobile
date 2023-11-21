import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/category/category_model.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/foods/foods_by_category_id_screen.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.goToPage(
          context: context,
          screen: FoodByCategoryIdScreen(
            categoryId: category.categoryId!,
            categoryName: category.category.toString(),
          ),
        );
      },
      child: GridTile(
        header: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppColors.darkBackground.withOpacity(0.5),
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
            child: CachedNetworkImage(
              imageUrl: category.categoryThumbnail.toString(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                AppImages.logo,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
