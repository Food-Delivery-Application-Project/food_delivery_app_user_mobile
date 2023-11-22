import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class FovoriteScreen extends StatefulWidget {
  const FovoriteScreen({super.key});

  @override
  State<FovoriteScreen> createState() => _FovoriteScreenState();
}

class _FovoriteScreenState extends State<FovoriteScreen> {
  WishlistBloc wishlistBloc = WishlistBloc();

  // Scroll controller for pagination
  ScrollController scrollController = ScrollController();

  // Pagination variables
  int page = 1;
  int paginatedBy = 2;

  List<FoodModel> food = [];

  @override
  void initState() {
    // increment page number when user scrolls to the bottom of the page
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
      }
    });
    getInitailData();
    super.initState();
  }

  getInitailData() {
    UserSecureStorage.fetchUserId().then((value) {
      wishlistBloc.add(WishlistGetInitialDataEvent(
        userId: value.toString(),
        page: page,
        paginatedBy: paginatedBy,
      ));
    });
  }

  getMoreData() {
    UserSecureStorage.fetchUserId().then((value) {
      wishlistBloc.add(WishlistGetMoreDataEvent(
        userId: value.toString(),
        page: page,
        paginatedBy: paginatedBy,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listener: (context, state) {
            if (state is WishlistInitialLoadedState) {
              food.addAll(state.foods.data);
            } else if (state is WishlistGetMoreLoadedState) {
              food.addAll(state.foods.data);
            }
          },
          builder: (context, state) {
            if (state is WishlistInitalLoadingState) {
              return const Center(
                child: LoadingWidget(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        return FoodItem(foodModel: food[index]);
                      },
                      itemCount: food.length,
                      shrinkWrap: true,
                    ),
                    10.height,
                    food.length < paginatedBy
                        ? Container()
                        : ElevatedButton(
                            onPressed: () {
                              page++;
                              getMoreData();
                            },
                            child: const Text("Load More"),
                          ),
                    20.height,
                    const Center(
                      child: LoadingWidget(),
                    ).visible(state is WishlistGetMoreLoadingState),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
