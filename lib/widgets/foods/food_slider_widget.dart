import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/food/food_bloc.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/foods/food_details_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class RandomCategoryItemWidget extends StatefulWidget {
  const RandomCategoryItemWidget({Key? key}) : super(key: key);

  @override
  State<RandomCategoryItemWidget> createState() =>
      _RandomCategoryItemWidgetState();
}

class _RandomCategoryItemWidgetState extends State<RandomCategoryItemWidget> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodBloc, FoodState>(listener: (context, state) {
      if (state is RandomFoodLoadedState) {
        // change the page index
        pageIndex = state.food.data.length - 1;
      }
    }, builder: (context, state) {
      if (state is RandomFoodLoadedState) {
        return Stack(
          children: [
            CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
                items: state.food.data.map((foodItemModel) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          AppNavigator.goToPage(
                            context: context,
                            screen: FoodDetailsScreen(food: foodItemModel),
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CachedNetworkImage(
                            imageUrl: foodItemModel.image!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList()),
            // add carousel indicator with switching effect
            Positioned(
              bottom: 10,
              right: 10,
              child: CarouselIndicator(
                count: state.food.data.length,
                index: pageIndex,
                color: AppColors.white,
                activeColor: AppColors.primary,
                height: 10,
                width: 10,
                space: 5,
                cornerRadius: 50,
              ),
            ),
          ],
        ).visible(state.food.data.isNotEmpty);
      } else if (state is FoodLoadingState) {
        return CarouselSlider(
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {
                pageIndex = index;
              },
              scrollDirection: Axis.horizontal,
            ),
            items: List.generate(3, (index) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.darkGrey.withOpacity(0.3),
                          AppColors.lightGrey,
                          AppColors.darkGrey.withOpacity(0.3),
                        ],
                        begin: const Alignment(-1.0, -0.5),
                        end: const Alignment(1.0, 0.5),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // margin:
                        //     const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList());
      } else {
        return Container();
      }
    });
  }
}
