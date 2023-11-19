import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/utils/app_grid_delegate.dart';
import 'package:food_delivery_app/widgets/category/category_widget.dart';
import 'package:food_delivery_app/widgets/divider/app_divider.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';
import 'package:food_delivery_app/widgets/text/heading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: AppTextStyle.headings,
                ),
                10.height,
                const FoodCategories(),
                20.height,
                const AppDivider(),
                20.height,
                // Favorites
                const HeadingWidget(
                  headingText: "Favorites",
                  isViewAll: true,
                ),
                const FavoriteFoods(),
                40.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCategories extends StatelessWidget {
  const FoodCategories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: AppGridDelegate.categories,
      itemBuilder: (context, index) => const CategoryWidget(),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class FavoriteFoods extends StatelessWidget {
  const FavoriteFoods({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: AppGridDelegate.foodItems,
      itemBuilder: (context, index) => const FoodItem(),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
