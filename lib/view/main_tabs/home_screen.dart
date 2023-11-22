// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/category/all_categories_bloc.dart';
import 'package:food_delivery_app/blocs/food/food_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_builders.dart';
import 'package:food_delivery_app/utils/app_grid_delegate.dart';
import 'package:food_delivery_app/widgets/category/category_widget.dart';
import 'package:food_delivery_app/widgets/divider/app_divider.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';
import 'package:food_delivery_app/widgets/foods/food_slider_widget.dart';
import 'package:food_delivery_app/widgets/shimmer/category_shimmer.dart';
import 'package:food_delivery_app/widgets/text/heading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AllCategoriesBloc>().add(GetAllCategoriesEvent());
        context.read<FoodBloc>().add(RandomFoodEvent());
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RandomCategoryItemWidget(),
              20.height,
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
      ),
    );
  }
}

class FoodCategories extends StatelessWidget {
  const FoodCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCategoriesBloc, AllCategoriesState>(
      builder: (context, state) {
        if (state is AllCategoriesLoadingState) {
          return AppBuilders.categories(
              (context, index) => const CategoryShimmer(), 4);
        } else if (state is AllCategoriesErrorState) {
          return Text(state.message);
        } else if (state is AllCategoriesLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories", style: AppTextStyle.headings),
              10.height,
              AppBuilders.categories(
                (context, index) {
                  return CategoryWidget(
                    category: state.categories.data[index],
                  ).visible(state.categories.data.isNotEmpty);
                },
                state.categories.data.length,
              ),
            ],
          ).visible(state.categories.data.isNotEmpty);
        } else {
          return Container();
        }
      },
    );
  }
}

class FavoriteFoods extends StatelessWidget {
  const FavoriteFoods({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: AppGridDelegate.foodItems,
      itemBuilder: (context, index) => FoodItem(foodModel: FoodModel()),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
