// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/blocs/category/all_categories_bloc.dart';
import 'package:food_delivery_app/blocs/food/food_bloc.dart';
import 'package:food_delivery_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_builders.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/main_tabs/wishlist_screen.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/category/category_widget.dart';
import 'package:food_delivery_app/widgets/divider/app_divider.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';
import 'package:food_delivery_app/widgets/foods/food_slider_widget.dart';
import 'package:food_delivery_app/widgets/shimmer/category_shimmer.dart';
import 'package:food_delivery_app/widgets/shimmer/food_item_shimmer.dart';
import 'package:food_delivery_app/widgets/text/heading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AllCategoriesBloc>().add(GetAllCategoriesEvent());
        context.read<FoodBloc>().add(RandomFoodEvent());
        context.read<WishlistBloc>().add(WishlistGetInitialDataEvent());
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StoriesWidget(),
              20.height,
              const RandomCategoryItemWidget(),
              20.height,
              const FoodCategories(),
              20.height,
              const RandomFoods(),
              20.height,
              const FavoriteFoods(),
              40.height,
            ],
          ),
        ),
      ),
    );
  }
}

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeadingWidget(
          headingText: "What's New",
          isViewAll: false,
        ),
        10.height,
        SizedBox(
          height: 80.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      // make story circular
                      shape: BoxShape.circle,
                      // add border to story
                      border: Border.all(color: AppColors.primary, width: 2),
                      // add image to story
                      image: const DecorationImage(
                        image: AssetImage(AppImages.logoTrans),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const AppDivider(),
      ],
    );
  }
}

class RandomFoods extends StatefulWidget {
  const RandomFoods({Key? key}) : super(key: key);

  @override
  State<RandomFoods> createState() => _RandomFoodsState();
}

class _RandomFoodsState extends State<RandomFoods> {
  FoodBloc foodBloc = FoodBloc();

  @override
  void initState() {
    super.initState();
    foodBloc.add(RandomFoodEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      bloc: foodBloc,
      builder: (context, state) {
        if (state is RandomFoodLoadedState) {
          return Column(
            children: [
              HeadingWidget(
                headingText: "Available Foods",
                isViewAll: false,
                callback: () {
                  AppNavigator.goToPage(
                    context: context,
                    screen: const Scaffold(
                      appBar: BackAppbarWidget(),
                      body: WishlistScreen(),
                    ),
                  );
                },
              ),
              10.height,
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.food.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: FoodItem(
                              foodModel: state.food.data[index],
                            ),
                          ),
                        ),
                        const AppDivider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ).visible(state.food.data.isNotEmpty);
        } else {
          return const SizedBox();
        }
      },
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
          return SizedBox(
            height: 200,
            child: AppBuilders.categories(
                (context, index) => Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const AspectRatio(
                        aspectRatio: 1,
                        child: CategoryShimmer(),
                      ),
                    ),
                4),
          );
        } else if (state is AllCategoriesErrorState) {
          return Text(state.message);
        } else if (state is AllCategoriesLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories", style: AppTextStyle.headings),
              10.height,
              SizedBox(
                height: 200.h,
                child: AppBuilders.categories(
                  (ctx, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CategoryWidget(
                          category: state.categories.data[index],
                        ),
                      ),
                    );
                  },
                  state.categories.data.length,
                ),
              ),
              20.height,
              const AppDivider(),
            ],
          ).visible(state.categories.data.isNotEmpty);
        } else {
          return Container();
        }
      },
    );
  }
}

class FavoriteFoods extends StatefulWidget {
  const FavoriteFoods({Key? key}) : super(key: key);

  @override
  State<FavoriteFoods> createState() => _FavoriteFoodsState();
}

class _FavoriteFoodsState extends State<FavoriteFoods> {
  List<FoodModel> foods = [];

  // scroll controller
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // increment page number when user scrolls the list view builder
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     wishlistPage++;
    //     wishlistGetMoreData();
    //   }
    // });
    super.initState();
    wishlistGetInitialData();
  }

  wishlistGetInitialData() {
    context.read<WishlistBloc>().add(WishlistGetInitialDataEvent());
  }

  wishlistGetMoreData() {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {
        if (state is WishlistInitialLoadedState) {
          foods.addAll(state.foods.data);
        }
      },
      builder: (context, state) {
        if (state is WishlistInitalLoadingState) {
          // return list view builder shimmer for food product
          return SizedBox(
            height: 200,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const FoodItemShimmer(),
                );
              },
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingWidget(
              headingText: "Favorites",
              isViewAll: true,
              callback: () {
                AppNavigator.goToPage(
                  context: context,
                  screen: const Scaffold(
                    appBar: BackAppbarWidget(),
                    body: WishlistScreen(),
                  ),
                );
              },
            ),
            10.height,
            SizedBox(
              height: 200,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: FoodItem(
                        foodModel: foods[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ).visible(foods.isNotEmpty);
      },
    );
  }
}
